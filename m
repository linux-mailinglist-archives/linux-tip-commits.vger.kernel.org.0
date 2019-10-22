Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C37DE055F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Oct 2019 15:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731418AbfJVNn3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 22 Oct 2019 09:43:29 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44606 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731405AbfJVNn3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 22 Oct 2019 09:43:29 -0400
Received: by mail-qt1-f194.google.com with SMTP id z22so6291584qtq.11
        for <linux-tip-commits@vger.kernel.org>; Tue, 22 Oct 2019 06:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=65KxlUgC9dSPCPxluWGpG2Vl2DybtBrKpaxLtCDmHzc=;
        b=sZh3QHiWg0ErSkdchcq9C2bNHfaB9FFK1TxVvrTpcladz6F6MxvNFYgfj9igb1TMYi
         20N2iPQ7JIdvKsXYIPCra8KZvODJlp+v2xUSAfVyBo6b0s+8UzRGrFFv9lv/fX0KVqgm
         VP7vpiOze4N6BvhqkCnu6x8fAobTKNtR1QuAm+jA1aiBnLj5cHE78Npe46S2HytmuTPC
         uG2iNSTJIBm4nfiw1LxIq94TBbgUr5sD5kjAq3X5ihjenBsbd0xvxo5rqd+A+01k47eY
         jGMH1LSVy8+/Rhikeqc56iHpvhqNvTF1YAZZqg0rVPzvCkQjOAE7YlFnbknzCHpatDr2
         C6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=65KxlUgC9dSPCPxluWGpG2Vl2DybtBrKpaxLtCDmHzc=;
        b=Ke2MxVEw1urMYnCTGbBc2Z36GYV1UDhHej6WTMGsrh+7zeYRlNxH2s6U65KBrc6dYO
         H/oEZUaikIVe/asNyEH9VCCBRh6QZo3HE7KeQic6lwew4oq+iqJ9hkiFWoCwNLKPK7Df
         OI9+eO1Kq5ip2bFTxkaLDdWdymGTGkevoE+LdQKC1qFv+fas1g4oE86lLHl1xLhj/jGE
         6qBanTP3I1QzF/DEbofyYydVfpgwgdzrhL+5pwi2YIRE5ojSrcFPysogrRYM3gJQ9WgJ
         nzJFeaZMWVyaKD+iLOGkI8iz/+Zm/hV2o/RpVx9zjHuJ4ZK/ayv2QEmbnyZPYL28sGJv
         9UoA==
X-Gm-Message-State: APjAAAUOHbDAI4IYv1qPWC086ewlu5DwdqtFDbDGHg9n+zBMnC7XkJtF
        YYQ1YVK68obA1iEqX5m6imQB6A==
X-Google-Smtp-Source: APXvYqzCGQx5Type9/3R4qna/nTI9GQItYm4YhOPt3qdM0/D7iFzAiNaQAlIDY7dcqE9vYIXIEd0HA==
X-Received: by 2002:ac8:28e3:: with SMTP id j32mr3149168qtj.212.1571751808706;
        Tue, 22 Oct 2019 06:43:28 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li937-157.members.linode.com. [45.56.119.157])
        by smtp.gmail.com with ESMTPSA id f10sm8191127qth.40.2019.10.22.06.43.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Oct 2019 06:43:26 -0700 (PDT)
Date:   Tue, 22 Oct 2019 21:43:08 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: Re: [tip: perf/core] perf tests: Disable bp_signal testing for arm64
Message-ID: <20191022134308.GD32731@leoy-ThinkPad-X240s>
References: <20191018085531.6348-3-leo.yan@linaro.org>
 <157169993406.29376.12473771029179755767.tip-bot2@tip-bot2>
 <20191022131423.GA17920@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022131423.GA17920@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Tue, Oct 22, 2019 at 02:14:25PM +0100, Will Deacon wrote:

[...]

> > diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
> > index c1c2c13..166f411 100644
> > --- a/tools/perf/tests/bp_signal.c
> > +++ b/tools/perf/tests/bp_signal.c
> > @@ -49,14 +49,6 @@ asm (
> >  	"__test_function:\n"
> >  	"incq (%rdi)\n"
> >  	"ret\n");
> > -#elif defined (__aarch64__)
> > -extern void __test_function(volatile long *ptr);
> > -asm (
> > -	".globl __test_function\n"
> > -	"__test_function:\n"
> > -	"str x30, [x0]\n"
> > -	"ret\n");
> > -
> >  #else
> >  static void __test_function(volatile long *ptr)
> >  {
> > @@ -302,10 +294,15 @@ bool test__bp_signal_is_supported(void)
> >  	 * stepping into the SIGIO handler and getting stuck on the
> >  	 * breakpointed instruction.
> >  	 *
> > +	 * Since arm64 has the same issue with arm for the single-step
> > +	 * handling, this case also gets suck on the breakpointed
> > +	 * instruction.
> 
> Freudian slip?

:D  sorry for typo: s/suck/stuck.

Thanks for review and will send a patch to fix it.

Thanks,
Leo Yan
