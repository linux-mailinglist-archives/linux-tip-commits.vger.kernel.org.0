Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F0677848E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Aug 2023 02:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjHKAiH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 10 Aug 2023 20:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjHKAiG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 10 Aug 2023 20:38:06 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C6AE7F
        for <linux-tip-commits@vger.kernel.org>; Thu, 10 Aug 2023 17:38:05 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99c0cb7285fso199976466b.0
        for <linux-tip-commits@vger.kernel.org>; Thu, 10 Aug 2023 17:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691714284; x=1692319084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NkgHjHcvv02JLA5d7L4Oy9GtZPKfjzxj4synHJJ/uXE=;
        b=bYaKtwd/TgMJVcIGH417oLRnGhU15YTlWNKl77y6xJuM6ET4RvpzElut2U4VLGJ0zu
         QG8wnHvu298UTxVQVBA9G5RQRgNRn4N4cp7ujswe8KxYOf4UqAGTHgq66gdJxkFYOTPx
         EH7atJcXPkg0RYcUL6ls21udZc63PbK1zu0sU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691714284; x=1692319084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NkgHjHcvv02JLA5d7L4Oy9GtZPKfjzxj4synHJJ/uXE=;
        b=MNqKr2crWdPc/lxpVjVmVVY4Dr3xBRvujN0NDGtysH1Kibaoij3B/JyzQWIwUzStyo
         fFwV+nBst8yykmzr4PbSm6Ip4P3DmcS7TNB2cNW3VAKJb1dxEjM7k8WUzS+KFPXa8xvW
         ePK8ItkTCzBXUo8OgAx8JDaixUQCbAnQdr1bY4obu/5VwJqlGRzciL7ZL0DKZizNr/dT
         Rgg/O8svr/w/7vUhByRyrXfKFCUuneNAcI6l69EXROQKUqUj7Xo20sElEhWA+kkGwblX
         mqkvdoB7XyoYQVWTIi4tVwnsk1VB4zN/LuekGozBwMI5EhKSV0lRIfdQ/M6p1bU3i1K+
         WcQg==
X-Gm-Message-State: AOJu0Yxhp6sC7FwFobRn9zs85UEbZaE1k7Q8CJWBJ84MHb0YG9KlHYbH
        Oud9zaWnVYubeE/kOisiMxWbRlghcoUEPIuVa/mEAt/W
X-Google-Smtp-Source: AGHT+IH+9C4Uiow9qHlcrgIrkHHh7fUitOyDsjHheoofpkqJsDok04pQ2YPFfsFF02dEUNTtJyJMvg==
X-Received: by 2002:a17:906:74dc:b0:993:f349:c98c with SMTP id z28-20020a17090674dc00b00993f349c98cmr377454ejl.4.1691714283867;
        Thu, 10 Aug 2023 17:38:03 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a10-20020a170906244a00b00992d70f8078sm1542115ejb.106.2023.08.10.17.38.02
        for <linux-tip-commits@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 17:38:03 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so1811815a12.1
        for <linux-tip-commits@vger.kernel.org>; Thu, 10 Aug 2023 17:38:02 -0700 (PDT)
X-Received: by 2002:aa7:c446:0:b0:523:4c93:1c0f with SMTP id
 n6-20020aa7c446000000b005234c931c0fmr384315edr.21.1691714282708; Thu, 10 Aug
 2023 17:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230809-gds-v1-1-eaac90b0cbcc@google.com> <169165870802.27769.15353947574704602257.tip-bot2@tip-bot2>
 <20230810162524.7c426664@kernel.org> <20230810172858.12291fe6@kernel.org>
In-Reply-To: <20230810172858.12291fe6@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Aug 2023 17:37:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_b+FGTnevQSBAtCWuhCk=0oQ_THvthBW2hzqpOTLFmg@mail.gmail.com>
Message-ID: <CAHk-=wj_b+FGTnevQSBAtCWuhCk=0oQ_THvthBW2hzqpOTLFmg@mail.gmail.com>
Subject: Re: [tip: x86/bugs] x86/srso: Fix build breakage with the LLVM linker
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Daniel Kolesa <daniel@octaforge.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Sven Volkinsfeld <thyrc@gmx.net>,
        Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Thu, 10 Aug 2023 at 17:29, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Are the commit IDs stable on x86/bugs?

I think normally yes.

> Would it be rude if we pulled that in?

If this is holding stuff up, you have a pretty good excuse. It
shouldn't be the normal workflow, but hey, it's not a normal problem.

As I mentioned elsewhere, I hate the embargoed stuff, and every single
time it happens I expect fallout from the fact that we couldn't use
the usual bots for build and boot testing.

All our processes are geared towards open development, and I think
that's exactly how they *should* be.

But then that means that they fail horribly for the embargoes.

Anyway, go ahead and just pull in the fixes if this holds up your
normal workflow.

And if we end up with duplicates due to rebases (or worse yet, merge
issues due to rebases with other changes), it is what it is. Can't
blame you.

              Linus
