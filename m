Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423C07A23D7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Sep 2023 18:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjIOQpq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Sep 2023 12:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbjIOQpl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Sep 2023 12:45:41 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86188AC
        for <linux-tip-commits@vger.kernel.org>; Fri, 15 Sep 2023 09:45:36 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31ff2ce9d4cso835232f8f.0
        for <linux-tip-commits@vger.kernel.org>; Fri, 15 Sep 2023 09:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694796335; x=1695401135; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bJwjiYuT81Vygr2N0E8vRZWFku28/3vgWmNofvmCcbw=;
        b=Zsf17i2BHOg2bqX/csLCyCR4KncD6guhNdeey+swDy2GajbCyni0b9CyCekbnyCxct
         fZukDkB7bS2yeF3CazzZV2xOrO6qWw5SR/Zo9nrfdBhjdkucHrYY2rWwwh5wRqb7KTrr
         oADYr704P5ISNQXfYxGVF1n0jZtF0UmJFC6Qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694796335; x=1695401135;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJwjiYuT81Vygr2N0E8vRZWFku28/3vgWmNofvmCcbw=;
        b=pqVFzZcMG0qeCC4bhjh23P/XXHDycVVgktV3byZl+NzFpy9Q5zJ8FrMUkqLrHfhGCa
         9XXCtz4utEDyiRvsgYNhk0BLib7EXsC3Qy8MQo/iXals87lP03R12i7dQjj4t4WJ0sFx
         y4hjVMIPzBsmfg7v9FBJLcx4FV4+EJyOnmLgOzIemnRMlruX9KkPGWlYvvJx2Q/tHwyW
         WmJ9dMbm7QOd7aSG2J+Xqoee+3n9c/7isHhqEYiJMXUMEgHe2nFSvQaDvUkuHwrRr1pv
         lx1yFL93aMeI05oRDv5N+XladQ1Geq+gen3LCvysdVv+vXlaB+Ivv4Cyr8g34rgBIMRZ
         ALtQ==
X-Gm-Message-State: AOJu0YwQd/PGWZKYeGbBd6SRyFA6Cgn0m7yrASJjvJBZVwD+PwyxByZd
        v+O8BMgZ40M49EiZSRtp5fqlAa4AVPqUDIX14YA=
X-Google-Smtp-Source: AGHT+IHDuR7Zf6mrv0LsNNVC95pM18wH0ciO9xHLhcRx4qwrhckuRFYXMc+c7FMCHl8tlCGbc4DpRQ==
X-Received: by 2002:adf:a3c4:0:b0:31f:f664:d87 with SMTP id m4-20020adfa3c4000000b0031ff6640d87mr1655321wrb.20.1694796334668;
        Fri, 15 Sep 2023 09:45:34 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id z11-20020aa7d40b000000b005255f5735adsm2506885edq.24.2023.09.15.09.45.33
        for <linux-tip-commits@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 09:45:33 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-9ad8d47ef2fso289147166b.1
        for <linux-tip-commits@vger.kernel.org>; Fri, 15 Sep 2023 09:45:33 -0700 (PDT)
X-Received: by 2002:a17:906:300e:b0:9a6:6c5b:ae0c with SMTP id
 14-20020a170906300e00b009a66c5bae0cmr2000660ejz.23.1694796333328; Fri, 15 Sep
 2023 09:45:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230906185941.53527-1-ubizjak@gmail.com> <169477710252.27769.14094735545135203449.tip-bot2@tip-bot2>
In-Reply-To: <169477710252.27769.14094735545135203449.tip-bot2@tip-bot2>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Sep 2023 09:45:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiOH-VK8XLUBU-=kzPij9X=m7HwnviXF-o8X54Z=Ey_xw@mail.gmail.com>
Message-ID: <CAHk-=wiOH-VK8XLUBU-=kzPij9X=m7HwnviXF-o8X54Z=Ey_xw@mail.gmail.com>
Subject: Re: [tip: x86/asm] x86/percpu: Define {raw,this}_cpu_try_cmpxchg{64,128}
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org, Uros Bizjak <ubizjak@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Fri, 15 Sept 2023 at 04:25, tip-bot2 for Uros Bizjak
<tip-bot2@linutronix.de> wrote:
>
> Several places in mm/slub.o improve from e.g.:
>
[...]
>
> to:
>
>     53bc:       48 8d 4a 40             lea    0x40(%rdx),%rcx
>     53c0:       49 8b 1c 07             mov    (%r15,%rax,1),%rbx
>     53c4:       4c 89 f8                mov    %r15,%rax
>     53c7:       48 8d 37                lea    (%rdi),%rsi
>     53ca:       e8 00 00 00 00          call   53cf <...>
>                         53cb: R_X86_64_PLT32     this_cpu_cmpxchg16b_emu-0x4
>     53cf:       75 bb                   jne    538c <...>

Honestly, if y ou care deeply about this code sequence, I think you
should also move the "lea" out of the inline asm.

Both

    call this_cpu_cmpxchg16b_emu

and

    cmpxchg16b %gs:(%rsi)

are 5 bytes, and I suspect it's easiest to just always put the address
in %rsi - whether you call the function or not.

It doesn't really make the code generation for the non-call sequence
worse, and it gives the compiler more information (ie instead of
clobbering %rsi, the compiler knows what %rsi contains).

IOW, something like this:

-       asm qual (ALTERNATIVE("leaq %P[var], %%rsi; call
this_cpu_cmpxchg16b_emu", \
+       asm qual (ALTERNATIVE("call this_cpu_cmpxchg16b_emu",           \
...
-                   "c" (new__.high)                                    \
-                 : "memory", "rsi");                                   \
+                   "c" (new__.high),                                   \
+                   "S" (&_var)                                   \
+                 : "memory");                                          \

should do it.

Note that I think this is particularly true of the slub code, because
afaik, the slub code will *only* use the slow call-out.

Why? Because if the CPU actually supports the cmpxchgb16 instruction,
then the slub code won't even take this path at all - it will do the
__CMPXCHG_DOUBLE path, which does an unconditional locked cmpxchg16b.

Maybe I'm misreading it. And no, none of this matters. But since I saw
the patch fly by, and slub.o mentioned, I thought I'd point out how
silly this all is. It's optimizing a code-path that is basically never
taken, and when it *is* taken, it can be improved further, I think.

                   Linus
