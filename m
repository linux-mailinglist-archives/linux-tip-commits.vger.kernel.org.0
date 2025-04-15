Return-Path: <linux-tip-commits+bounces-4985-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3074AA8911C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Apr 2025 03:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90D211897B40
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Apr 2025 01:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55341F63D9;
	Tue, 15 Apr 2025 01:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="m06HtX4E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E8922F11;
	Tue, 15 Apr 2025 01:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744680059; cv=none; b=IcO5Xvc6c1vxJ6YaC5RzrB+W9te9vU9VLuHtv0GzmFFutx46cAtIUerg+Bgyp4JrS2O/zRq0YSLOrWnJBui7cGX0W472D9JrvhxCBhIyoVduBsjnhnvCwec+Hd7eylmYDW7BwY7qAJZOU98R6Z6hbUf+xg12HwXiglI5qOJS7og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744680059; c=relaxed/simple;
	bh=yAG8a7VOxyqfeQU4QrGwGKgZYrxnvOPALzXLWx/1emE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Mpq2YT+367C8QMKQAhaRNH+N1p1BPsYMbMM39TJSprVKVUJ4mNZofb5ETTdEskSMd9TR4+RXaq1pY7UDnx0/W4h5kyBQecfyWaVfcoWO/6SF5zdv5ntibgCRU3mZFLx+867aGiEx4Q+l1kg28SDj/Mb7FfuiQDW+JZkr44D8Mi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=m06HtX4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670A8C4CEE2;
	Tue, 15 Apr 2025 01:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1744680058;
	bh=yAG8a7VOxyqfeQU4QrGwGKgZYrxnvOPALzXLWx/1emE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m06HtX4EdsQFep3Bm2GsqRHUI8vWx15sYe4l6z1sjZq7rNo4UB0DBG/SEHhI39MUT
	 ilqWV3pl9IgSMGHqW4czpCf2V8ETLY1zDTmyaq8zxYx12HJ4P4COxhbc4Uf5IElzjH
	 WXy0nVc7cAiFuiYnnn/jKRvBPjmYgD24chP31bgY=
Date: Mon, 14 Apr 2025 18:20:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>, Borislav Petkov
 <bp@alien8.de>, linux-kernel@vger.kernel.org,
 linux-tip-commits@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
 x86@kernel.org
Subject: Re: [tip: core/urgent] compiler.h: Avoid the usage of
 __typeof_unqual__() when __GENKSYMS__ is defined
Message-Id: <20250414182057.fe2fc32273ca1520c9b5dd4d@linux-foundation.org>
In-Reply-To: <Z_wOYOrVJJkUUUF9@gmail.com>
References: <20250404102535.705090-1-ubizjak@gmail.com>
	<174428272631.31282.1484467383146370221.tip-bot2@tip-bot2>
	<20250411210815.GAZ_mEv8riLWzvERYY@renoirsky.local>
	<Z_oqalk92C4G6Rqt@gmail.com>
	<CAFULd4bTd6GMftLBX7Nu0xftini00o4v7=1XfuoDC8ydUr9Ueg@mail.gmail.com>
	<Z_t7_brzSoboOsen@gmail.com>
	<CAFULd4ZBbAG4ndn+rzjjqF+pmtGa3UbyDOWfEXww0XhExJByVA@mail.gmail.com>
	<Z_wI0uNoG2G2TQMC@gmail.com>
	<CAFULd4b2afcu5PnxhqwwepwWMSA7mvYNyPnMtkCjjT84VG8VXA@mail.gmail.com>
	<Z_wOYOrVJJkUUUF9@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Apr 2025 21:20:00 +0200 Ingo Molnar <mingo@kernel.org> wrote:

> > > > If this commit is removed, [...]
> > >
> > > I did not remove commit ac053946f5c4, it's already upstream. Nor 
> > > did I advocate for it to be reverted - I'd like it to be fixed. So 
> > > you are barking up the wrong tree.
> > 
> > If the intention is to pass my proposed workaround via Andrew's tree, 
> > then I'm happy to bark up the wrong tree, but from the referred 
> > message trail, I didn't get the clear decision about the patch, and 
> > neither am sure which patch "brown paper bag bug" refers to.
> 
> It's up to akpm (he merged your original patch that regressed), but I 
> think scripts/genksyms/ should be fixed instead of worked around - 
> which is why I zapped the workaround.

I'm OK with the original workaround - super simple and fixes the issue.
I don't know if Borislav intends to upstream this, so I'll grab a copy
also.

Nobody has commented on Uros's more recent alteration to genksyms
(https://lkml.kernel.org/r/CAFULd4aLMF_2AbUAvpYw+o1qo6U-Ya_+Ewy-wW17g-r-MBF9_g@mail.gmail.com)?

Uros, please persist with that approach and hopefully we'll have a
patch which removes the temporary workaround.



