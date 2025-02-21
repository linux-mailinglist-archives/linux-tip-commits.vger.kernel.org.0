Return-Path: <linux-tip-commits+bounces-3586-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B68A3FF32
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 20:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B6F74250F1
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 19:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863EC1FBCB9;
	Fri, 21 Feb 2025 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MYyLuZLZ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0BC250BE2;
	Fri, 21 Feb 2025 19:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740164428; cv=none; b=OCfz1HbyaKh6le1yITr77eqbkUv8XKIdWSoLVs36UGFHDUpLXr0T8xoZwzWb8EDSpjmH/f9SOC9aPbaSLGj7WGiQ5N/jSAX44l91R5uiHS1tUMrhpaSz2421vPnEbpVd8ANKi/GDjYBVdnBU9Te1SaTBt4kaBauFesZFHmWQwk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740164428; c=relaxed/simple;
	bh=2DJbcPAlnmYMg/YH6xv67yojqyIGpaXTXrcVoLnrrfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VW3ET7w9ZmPXK9919vj2eicEypC5C2Y13AVLHQpaNUg55kBdjuEoZsfAvJeiV373FjOc96nlyJkh+R2aOZGyfAem1Df4eqhOxm1lfkDk7tlDmmj8G1Uf3gF0OKejpE/ACkt+DOjwAjWA16GTN+HQczFw5Pe7Myq+8L1QcvJZvUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MYyLuZLZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=80g6ycMVxqflWxvtoHRcSfE10QKxloxso5cwvGKnSvg=; b=MYyLuZLZ4Ruqj5DBd02jx+ghLE
	XMwDvhVd0x9r3DMifzKMqmOPr8Q7Mar89fES9ef/TcWNwIq9Ll7RPbnYQdPJsBtUVSBEYQuKxbBQd
	nQyyssymKwPzulVzmsq0ftbzTswuoG/G/R17RNsJT6CFA7x8w2JSKnBcSHkJjwWkpa81pcMHJ2EGC
	HSW9zO/ajr6AcA0Mic1STfhcemHm8gq4Frf68e9snsk9T5BMAdKekuiELKoD29D5U7cGekrn0fWkd
	UiiAUbN2edhc8eyMNScAxHmWBVCeCglaCRf0xJOO5rn67vT4EEjEcWoz7NT/s1feHk59d9FzWDwfj
	vVtXlHdg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tlYG8-0000000EmdZ-37a3;
	Fri, 21 Feb 2025 19:00:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 661CD30066A; Fri, 21 Feb 2025 20:00:24 +0100 (CET)
Date: Fri, 21 Feb 2025 20:00:24 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Kees Cook <kees@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [tip: x86/cpu] x86/kcfi: Require FRED for FineIBT
Message-ID: <20250221190024.GC7373@noisy.programming.kicks-ass.net>
References: <20250214192210.work.253-kees@kernel.org>
 <174015048551.10177.4353365227122906077.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174015048551.10177.4353365227122906077.tip-bot2@tip-bot2>

On Fri, Feb 21, 2025 at 03:08:05PM -0000, tip-bot2 for Kees Cook wrote:
> The following commit has been merged into the x86/cpu branch of tip:
> 
> Commit-ID:     f12315780faf1cbfe00991077a1e8c8e4c201f3b
> Gitweb:        https://git.kernel.org/tip/f12315780faf1cbfe00991077a1e8c8e4c201f3b
> Author:        Kees Cook <kees@kernel.org>
> AuthorDate:    Fri, 14 Feb 2025 11:22:21 -08:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Fri, 21 Feb 2025 15:38:11 +01:00

Ingo, seriously NO!

