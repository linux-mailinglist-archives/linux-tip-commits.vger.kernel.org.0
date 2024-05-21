Return-Path: <linux-tip-commits+bounces-1280-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D538CADC2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 May 2024 13:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A160A28340B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 May 2024 11:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862066BB33;
	Tue, 21 May 2024 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RJDr7M0W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kmPIISog"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D5274BE0;
	Tue, 21 May 2024 11:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716292660; cv=none; b=WgLUCLJKu5R/m2M97zlX0u/2d5Da2hdbpc+sxlsfMikshYaKLrMO8oDNsu0MgY8Dy76T0c2K9mEEA5+Z1KSm1tDLYN4PTIwL8YIIwQU5PByqhwCoFuvYGtzspfBMELeMSEonN8FaRKFnUMMXtlu97neBYkvMUm/OMpGCV8gN1QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716292660; c=relaxed/simple;
	bh=nnhFb/wvx2PR3+m0Ty495PAA6vitkX3EzNOBblvMy6I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ga332hxQILro2o9FaKpzOKmlhBE2UeQdxiYeXgGyN7SRhPStjPNNIqYa4XJC/fZOEx8PJKvyS1BeLfg7I24s5tiE/E5y8y7ai6HHN1oWxKRZFOYK0l/6NLkzQMYUwe/ITMosJzRN1F2uKz0vqEVcpi7L3Qo7+u5I40Vabt87bwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RJDr7M0W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kmPIISog; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 21 May 2024 11:57:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716292657;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=14wHwzFqDT+9RoiO88MxSEocndH60yvM2h5J4PUUcVQ=;
	b=RJDr7M0W7zfb9rZCQ7SsqFc7EXA0AC9n5TrKOvWLfpU2NBjrodEgwg2dD0RrPrjenS4+yI
	allC7LFlWyWfe5ni8KmnyMJZmne38FnLNpBY8UIqDgTeWUuQuENYrhsSoKklvWQaK35/lE
	oCCCGRLmWPYSScR//jrutvbGmahB9utnxV6gP8kU2y9Po9I04UeIlVEiAroJYddzhNCkTf
	v/Ey4XwZmHLI92XIabtXkPsXN/4jRwKsnADPSJjDtjWXOoGt71+Nbc9g/UxqwUp/W/7Zle
	EgU+CE4G2btd44mh3Jd/4MWR3lTDSt9cr5Xn3/OA+8vPGyVSnkiM/eXtRZRyaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716292657;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=14wHwzFqDT+9RoiO88MxSEocndH60yvM2h5J4PUUcVQ=;
	b=kmPIISog6spUSjcb+9NaYK5uGNbG/18Go4LLbn2+PYnveUq73IpqDuCp5VJHMKj+FhE6/x
	mdlDzG6Vc0iOovBw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/percpu: Enable named address spaces for all
 capable GCC versions
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240520082134.121320-1-ubizjak@gmail.com>
References: <20240520082134.121320-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171629265714.10875.4435975753899869099.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     47ff30cc1be7bf426c03ecc84371452109b416e4
Gitweb:        https://git.kernel.org/tip/47ff30cc1be7bf426c03ecc84371452109b416e4
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 20 May 2024 10:21:14 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 21 May 2024 10:17:01 +02:00

x86/percpu: Enable named address spaces for all capable GCC versions

Enable named address spaces also for GCC 6, GCC 7 and GCC 8
releases. These compilers all produce kernel images that boot
without problems.

Use compile-time test to detect compiler support for named
address spaces. The test passes with GCC 6 as the earliest
compiler version where the support for named address spaces
was introduced.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20240520082134.121320-1-ubizjak@gmail.com
---
 arch/x86/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9d16fee..c9e0a54 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2430,7 +2430,8 @@ source "kernel/livepatch/Kconfig"
 endmenu
 
 config CC_HAS_NAMED_AS
-	def_bool CC_IS_GCC && GCC_VERSION >= 90100
+	def_bool $(success,echo 'int __seg_fs fs; int __seg_gs gs;' | $(CC) -x c - -S -o /dev/null)
+	depends on CC_IS_GCC
 
 config CC_HAS_NAMED_AS_FIXED_SANITIZERS
 	def_bool CC_IS_GCC && GCC_VERSION >= 130300

