#let 字号 = (
  初号: 42pt,
  小初: 36pt,
  一号: 26pt,
  小一: 24pt,
  二号: 22pt,
  小二: 18pt,
  三号: 16pt,
  小三: 15pt,
  四号: 14pt,
  中四: 13pt,
  小四: 12pt,
  五号: 10.5pt,
  小五: 9pt,
  六号: 7.5pt,
  小六: 6.5pt,
  七号: 5.5pt,
  小七: 5pt,
)
#let skippedstate = state("skipped", false)
#let forewordcounter = counter("foreword")
#let partcounter = counter("part")
#let lengthceil(len, unit: 字号.小四) = calc.ceil(len / unit) * unit

#let chinese-outline = counter("chinese-outline")
#let chinesenumbering(..nums, location: none, brackets: false) = locate(loc => {
  
  let actual_loc = if location == none { loc } else { location }
  if forewordcounter.at(actual_loc).first() >= 10 {
    if nums.pos().len() == 1 {
      chinese-outline.step()
      context chinese-outline.display("第一章")
    } else {
      numbering(if brackets { "(1.1)" } else { "1.1" }, ..nums)
    }
  } else {
    if nums.pos().len() == 1 {
      none
    } else {
      numbering(if brackets { "(A.1)" } else { "A.1" }, ..nums)
    }
  }
})

#let chineseoutline(title: "目录", depth: none, indent: true) = {
  forewordcounter.update(10)
  heading(title, numbering: none, outlined: false)
  locate(it => {
    let elements = query(heading.where(outlined: true).after(it), it)

    for el in elements {
      // Skip list of images and list of tables
      if partcounter.at(el.location()).first() < 20 and el.numbering == none { continue }

      // Skip headings that are too deep
      if depth != none and el.level > depth { continue }

      let maybe_number = if el.numbering != none {
        if el.numbering == chinesenumbering {
          chinesenumbering(..counter(heading).at(el.location()), location: el.location())
        } else {
          numbering(el.numbering, ..counter(heading).at(el.location()))
        }
        h(0.5em)
      }

      let line = {
        h(1em * (el.level - 1))
        if el.level == 1 {
          v(1em, weak: true)
        }

        if maybe_number != none {
          style(styles => {
            let width = measure(maybe_number, styles).width
            box(
              width: lengthceil(width),
              link(el.location(), if el.level == 1 {
                strong(maybe_number)
              } else {
                maybe_number
              })
            )
          })
        }

        link(el.location(), if el.level == 1 {
          strong(el.body)
        } else {
          el.body
        })

        // Filler dots
        if el.level == 1 {
          box(width: 1fr, h(10pt) + box(width: 1fr) + h(10pt))
        } else {
          box(width: 1fr, h(10pt) + box(width: 1fr, repeat[.]) + h(10pt))
        }

        // Page number
        let footer = query(selector(<__footer__>).after(el.location()), el.location())
        let page_number = if footer == () {
          0
        } else {
          counter(page).at(footer.first().location()).first()
        }
        
        link(el.location(), if el.level == 1 {
          strong(str(page_number))
        } else {
          str(page_number)
        })

        linebreak()
        v(-0.2em)
      }

      line
    }
  })

  chinese-outline.update(0)
}


#let project(author: "", title: "", class: "", body) = {
  set document(author: author, title: title, date: datetime.today())

  set page(footer: locate(loc => {
      [
        #set text(字号.五号)
        #set align(center)
        #if query(selector(heading).before(loc), loc).len() < 2 {
          // Skip cover, copyright and origin pages
        } else {
          let headers = query(selector(heading).before(loc), loc)
          let part = partcounter.at(headers.last().location()).first()
          [
            #str(counter(page).at(loc).first())
          ]
        }
        #label("__footer__")
      ]
    }))

  set heading(numbering: chinesenumbering)
  show heading: it => {
    if it.level == 1 {
      set align(center)
      it
    } else {
      it
      v(0.4em)
    }
  }

  set page(numbering: "1 / 1", header: context {
    h(1fr)
    if counter(page).get().first() != 1 {
      [_ #title _]
    }
  })

  set par(first-line-indent: 2em)

  set text(font: ("Linux Libertine", "FZShuSong-Z01"), lang: "zh")
  show emph: text.with(font: ("Linux Libertine", "FZKai-Z03"))
  show strong: text.with(font: ("Linux Libertine", "FZXiaoBiaoSong-B05"))
  show heading: it => {
    if it.level == 1 {
      strong(it)
      v(1em)
    } else {
      strong(it)
    }
  }

  show link: it => {
    set text(fill: rgb("#3488f6"), weight: "thin")
    underline(it, offset: 2pt)
  }

  let get-text = it => {
    if it.func() == link {
      it.body.text
    } else {
      it.text
    }
  }

  show ref: it => {
    if it.element.func() == heading {
      let tmp = counter(get-text(it.element.body))
      tmp.update(counter(heading).at(it.target))
      let at = context tmp.display(it.element.fields().numbering)

      link(locate(it.element.location()), [#at #it.element.body])
    } else {
      it
    }
  }

  align(center)[
    #v(10em)
    #text([*#title*], size: 4em) \
    #v(5em)
    #text([*#author*], size: 2em) \
    #v(1em)
    #let today = datetime.today()
    #text([
      #today.year() 年 #today.month() 月 #today.day() 日 修订
    ], size: 1.5em)
  ]

  pagebreak()

  body
}