Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4968C7CC761
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Oct 2023 17:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344327AbjJQPYV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Oct 2023 11:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344304AbjJQPYV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Oct 2023 11:24:21 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981C79F
        for <linux-tip-commits@vger.kernel.org>; Tue, 17 Oct 2023 08:24:19 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c5028e5b88so62952571fa.3
        for <linux-tip-commits@vger.kernel.org>; Tue, 17 Oct 2023 08:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697556258; x=1698161058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJQt/dhfW4ljIETmg9qzLnjfnzaDOgcBSv1MQzSSlYg=;
        b=woL87RtJl1Y/f2Y3mwS/bFiJ2mzm78+NNbVdNuZCgGeGpFmIQiSp5BVK5n4AVHRc83
         W529plLHwMtLEIUOukaMLV27q8cgGRzNOWsEFfBa+I5MRvWA7jmssuK27zHvPLMVUzVf
         68Pr1b4+JD0Rp5uma+XOJ2fNp5yndEVuvinDXTgBGcS0W6zoANiYHApHcwdY9IjRTdHT
         ADHbxz4alIfxIrq1I7B5sNArB9SVE/Hr6rstoqP7yIjmzaxnpatsbZ5qbQ0no/CY4zMN
         wyGl9nqHSBFIhnyZeAoHZkwicx0UG/5lDE7m1haS0XAUXswrPPLCBB5f0VpMF6/T++XV
         SyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697556258; x=1698161058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJQt/dhfW4ljIETmg9qzLnjfnzaDOgcBSv1MQzSSlYg=;
        b=tcYRkJWwR7L++v/uiQpmJ39kba5cQOecsnCnYo698gzMHCR4vrd1ihgBbj713p9MnS
         8CjtRsxtuJCL4MvoBVgGbVZaS8IXi/6fNus8oEU1+4S6bvR88mHRWNJzDksiOeJNrIfJ
         Fl83KjT+qfhBgCOr2yEXe3Yw8Nod4a+Ka1rT3MGLZwnKkXKY50PwE3fxtgVWJEZ3NEoU
         UuxR8rqt2YBBkdx5bj07TwNxsQEUnf6uWfK1O8DkKWAZqlEq1iT8qxuJoqoJQ7Jahc17
         UVJJlYYITl0JMrkcTCpyw9l2I1Qf1XG9fzaDd4+Fhg1wE1qISS1RP1GBAFB6D+SaNYsl
         ijug==
X-Gm-Message-State: AOJu0Yw0tmjQwrQq8159taXn7QU+lVsUGYr32btMZFiH7fpknwsTtPc5
        7D/htDu0iU9F9+yTZkL7o5nbJmpuW0ySHYvpnn1GEA==
X-Google-Smtp-Source: AGHT+IFcz8ytMC/IKQ5VVicz7OafNbchdrmgX99jpUoYI5WmS8cc6u+FdSEjoNSsM21v3gMVwMJT/X6xSS/Kya8t5N0=
X-Received: by 2002:a19:6703:0:b0:507:b7db:1deb with SMTP id
 b3-20020a196703000000b00507b7db1debmr2213812lfc.38.1697556257664; Tue, 17 Oct
 2023 08:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231012141031.GHZSf+V1NjjUJTc9a9@fat_crate.local>
 <169713303534.3135.10558074245117750218.tip-bot2@tip-bot2>
 <20231016211040.GA3789555@dev-arch.thelio-3990X> <20231016212944.GGZS2rSCbIsViqZBDe@fat_crate.local>
 <20231016214810.GA3942238@dev-arch.thelio-3990X> <SN6PR12MB270273A7D1AF5D59B920C94194D6A@SN6PR12MB2702.namprd12.prod.outlook.com>
 <20231017052834.v53regh66hspv45n@treble>
In-Reply-To: <20231017052834.v53regh66hspv45n@treble>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 17 Oct 2023 08:24:02 -0700
Message-ID: <CAKwvOd=pA_gpxC9ZP-woRm2-+eSCSHtwvG3vsz9xugs-u3kAMQ@mail.gmail.com>
Subject: Re: [tip: x86/bugs] x86/retpoline: Ensure default return thunk isn't
 used at runtime
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     "Kaplan, David" <David.Kaplan@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

+ Marco, Dmitry

On Mon, Oct 16, 2023 at 10:28=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.or=
g> wrote:
>
> On Tue, Oct 17, 2023 at 04:31:09AM +0000, Kaplan, David wrote:
> > Perhaps another option would be to not compile these two files with KCS=
AN, as they are already excluded from KASAN and GCOV it looks like.
>
> I think the latter would be the easy fix, does this make it go away?

Yeah, usually when I see the other sanitizers being disabled on a per
object basis, I think "where there's smoke, there's fire."

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/lkml/20231016214810.GA3942238@dev-arch.thel=
io-3990X/

>
> diff --git a/init/Makefile b/init/Makefile
> index ec557ada3c12..cbac576c57d6 100644
> --- a/init/Makefile
> +++ b/init/Makefile
> @@ -60,4 +60,5 @@ include/generated/utsversion.h: FORCE
>  $(obj)/version-timestamp.o: include/generated/utsversion.h
>  CFLAGS_version-timestamp.o :=3D -include include/generated/utsversion.h
>  KASAN_SANITIZE_version-timestamp.o :=3D n
> +KCSAN_SANITIZE_version-timestamp.o :=3D n
>  GCOV_PROFILE_version-timestamp.o :=3D n
> diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
> index 3cd6ca15f390..c9f3e03124d7 100644
> --- a/scripts/Makefile.vmlinux
> +++ b/scripts/Makefile.vmlinux
> @@ -19,6 +19,7 @@ quiet_cmd_cc_o_c =3D CC      $@
>
>  ifdef CONFIG_MODULES
>  KASAN_SANITIZE_.vmlinux.export.o :=3D n
> +KCSAN_SANITIZE_.vmlinux.export.o :=3D n
>  GCOV_PROFILE_.vmlinux.export.o :=3D n
>  targets +=3D .vmlinux.export.o
>  vmlinux: .vmlinux.export.o
>


--=20
Thanks,
~Nick Desaulniers
