Return-Path: <linux-tip-commits+bounces-5207-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E65AA8447
	for <lists+linux-tip-commits@lfdr.de>; Sun,  4 May 2025 08:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B65C16B184
	for <lists+linux-tip-commits@lfdr.de>; Sun,  4 May 2025 06:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F84157A55;
	Sun,  4 May 2025 06:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPuMSq5s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FD51386C9;
	Sun,  4 May 2025 06:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746339268; cv=none; b=d6OMRmJ9N4KWnO1VQ9JFcC3UbRFZ4mlThzXYUC0FBoWghGliSJXLVIjgglIxJNnIUvtuKE8bu/LcjCD5kaIFati+y6f+HocyEy54ofhC1kkTnBmbPUiSvLeZm3IhkqRu48t1DvhqiNhA+1uK8PyZdp1ZrC/URwRYwV1H0yazEpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746339268; c=relaxed/simple;
	bh=diwepi3cFgrW3koHX4AcdP0nyiSSA4I1cuwM7ENZDgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umQI/AJXoG3tLf4xI2k9i4UD2BNISQ9rQMv7n07ctCR5nhJ0lC4p0qoMXOxC7DELXPKEbUx2rb7yabXWssYHoM9csQ5XCo1iCiBwI98e4PMc2+wZs5s680xXAPagnPDUFfCM448jRfrRTnzPyp6MJbw24a/kJMA/G0UB8HBcPeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPuMSq5s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45298C4CEE7;
	Sun,  4 May 2025 06:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746339267;
	bh=diwepi3cFgrW3koHX4AcdP0nyiSSA4I1cuwM7ENZDgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rPuMSq5s09PsrmePE5Tv2ycBpvVqBUnxeNpbUZyehM/xSpnKwU4R6i718QyUc3DX+
	 1sUDwwvZFYxjY2xP5rnQRykU25APAK5sborz6mrU8dIKBouzRGKHkqGQ7clvKg9JIw
	 NaU36uHUIatyzH/BXx6FFFaDTNXlNJQ3+Yyr9LFsONCBQQe78cE3pOwwLHYYFqHsOq
	 uisV6ucGoe/emd1yEhahnB6b7WRV4EGoRd/XXTFKeaSnqQ01bZH6D6XtZbPngRBGu3
	 xPuFcAn+i4T1alDA+/e5UlopdtGIvHzrrDeLG3nhNb7wfsU1tBOHhK4ymiBZmDesjZ
	 mSjM84EBtmhOg==
Date: Sun, 4 May 2025 08:14:23 +0200
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org,
	"Borislav Petkov (AMD)" <bp@alien8.de>, stable@kernel.org,
	x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/microcode: Consolidate the loader
 enablement checking
Message-ID: <aBcFv6BzmRNWqLY8@gmail.com>
References: <CANpbe9Wm3z8fy9HbgS8cuhoj0TREYEEkBipDuhgkWFvqX0UoVQ@mail.gmail.com>
 <174628529460.22196.11450380316905137027.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174628529460.22196.11450380316905137027.tip-bot2@tip-bot2>


* tip-bot2 for Borislav Petkov (AMD) <tip-bot2@linutronix.de> wrote:

> The following commit has been merged into the x86/urgent branch of tip:
> 
> Commit-ID:     eb72bdfbd0a757f30ebe4f9ec161cb246d19e5ed
> Gitweb:        https://git.kernel.org/tip/eb72bdfbd0a757f30ebe4f9ec161cb246d19e5ed
> Author:        Borislav Petkov (AMD) <bp@alien8.de>
> AuthorDate:    Mon, 14 Apr 2025 11:59:33 +02:00
> Committer:     Borislav Petkov (AMD) <bp@alien8.de>
> CommitterDate: Sat, 03 May 2025 16:40:56 +02:00
> 
> x86/microcode: Consolidate the loader enablement checking
> 
> Consolidate the whole logic which determines whether the microcode loader
> should be enabled or not into a single function and call it everywhere.
> 
> Well, almost everywhere - not in mk_early_pgtbl_32() because there the kernel
> is running without paging enabled and checking dis_ucode_ldr et al would
> require physical addresses and uglification of the code.
> 
> But since this is 32-bit, the easier thing to do is to simply map the initrd
> unconditionally especially since that mapping is getting removed later anyway
> by zap_early_initrd_mapping() and avoid the uglification.
> 
> Fixes: 4c585af7180c1 ("x86/boot/32: Temporarily map initrd for microcode loading")
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Cc: <stable@kernel.org>
> Link: https://lore.kernel.org/r/CANpbe9Wm3z8fy9HbgS8cuhoj0TREYEEkBipDuhgkWFvqX0UoVQ@mail.gmail.com

So the title claims this 'consolidates' microcode loader enablement, 
which is basically a code refactoring, but then there's a Fixes tag - 
what exactly does it fix? There's no explanation in the changelog that 
I can see that justifies that tag and why it's in x86/urgent.

Thanks,

	Ingo

