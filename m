Return-Path: <linux-tip-commits+bounces-3077-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F92D9F2D06
	for <lists+linux-tip-commits@lfdr.de>; Mon, 16 Dec 2024 10:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2934F1881F26
	for <lists+linux-tip-commits@lfdr.de>; Mon, 16 Dec 2024 09:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB44C1FF7CA;
	Mon, 16 Dec 2024 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bmD8o+gm"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55BB347B4;
	Mon, 16 Dec 2024 09:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734341540; cv=none; b=XWpksws1fbkrgNzvVRI7q0sefdAfjutXN/5DveId610xADAi0g4yTrZDzoj4An0gb3rytj3BfejnLlXx0SJDNwYTqVpUVNgaF6inYqJcLFLHisLoj64QwTzv7H6XocXfzgYP5EcJTn+G6PHyjTxCUuDSP8FEOc85NoqEz8/U1Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734341540; c=relaxed/simple;
	bh=eHDuhJrDWtNoQCCRmpWOIBKF9ykyUy/44poicFT/LXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/MG4AXjdq/JSRXSrfNZ+BpAaV+a2RkmEJNuDxCRrFIVvTszybQu1DN7ClxdjTP2B6d1MvtPXABQh6U94xY/JalvdLmqIqDXZO52pyGk9OW60l9nDyTtENASLNWKqtUyQ8Jm7oUvzd8C93wlwAJSORSQVW3CVQA2pIQj73OhflY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bmD8o+gm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wiPCFq4dyWxF7N4NTpB9RFuzOSDApJ/3JrMLkOH2sr8=; b=bmD8o+gmWCbOSBYlB6WtQp4UWo
	1npSSqhWJepe6bfloesgdRn8NkbFagRiEcu90hPuuC8LvN+8lYnjGvwgPgr7z5bRVrcIIX3p8NouY
	zQF56QscRFtlpNFsvS1TWtsHzfAcehJJRo1h3ecZvOFr0pHdITqka842AWcGq0K2CvWFxEcbPEFX2
	hKC7NCAy6+01br1h2sgTir8WPAqxgVc+IpN3hWGcgQwSriWB7iQmXMk0KnEQ0uAUrFsrZbtcMQVW5
	d3beOVgNwSod7XsKSp7OTeipuvrbJibRyFaKc+ZTuVU+voN3PcXURf03wmmhi49ELmEuFv2SCAuHl
	Wgf01HvA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tN7Sa-0000000F7p6-3pxz;
	Mon, 16 Dec 2024 09:32:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E898730031E; Mon, 16 Dec 2024 10:32:15 +0100 (CET)
Date: Mon, 16 Dec 2024 10:32:15 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
	x86@kernel.org
Subject: Re: [tip: objtool/core] x86: Convert unreachable() to BUG()
Message-ID: <20241216093215.GD12338@noisy.programming.kicks-ass.net>
References: <20241128094312.028316261@infradead.org>
 <173313812188.412.17754446990942244796.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173313812188.412.17754446990942244796.tip-bot2@tip-bot2>

On Mon, Dec 02, 2024 at 11:15:21AM -0000, tip-bot2 for Peter Zijlstra wrote:
> The following commit has been merged into the objtool/core branch of tip:
> 
> Commit-ID:     2190966fbc14ca2cd4ea76eefeb96a47d8e390df
> Gitweb:        https://git.kernel.org/tip/2190966fbc14ca2cd4ea76eefeb96a47d8e390df
> Author:        Peter Zijlstra <peterz@infradead.org>
> AuthorDate:    Thu, 28 Nov 2024 10:39:02 +01:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Mon, 02 Dec 2024 12:01:43 +01:00
> 
> x86: Convert unreachable() to BUG()
> 
> Avoid unreachable() as it can (and will in the absence of UBSAN)
> generate fallthrough code. Use BUG() so we get a UD2 trap (with
> unreachable annotation).
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Link: https://lore.kernel.org/r/20241128094312.028316261@infradead.org


Urgh, one got lost:

vmlinux.o: warning: objtool: page_fault_oops() falls through to next function is_prefetch()

---
 arch/x86/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index e6c469b323cc..ac52255fab01 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -678,7 +678,7 @@ page_fault_oops(struct pt_regs *regs, unsigned long error_code,
 			      ASM_CALL_ARG3,
 			      , [arg1] "r" (regs), [arg2] "r" (address), [arg3] "r" (&info));
 
-		unreachable();
+		BUG();
 	}
 #endif
 

