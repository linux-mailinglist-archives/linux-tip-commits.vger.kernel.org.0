Return-Path: <linux-tip-commits+bounces-4825-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 545A4A84150
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Apr 2025 12:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A3051B809CD
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Apr 2025 10:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46ED2676CD;
	Thu, 10 Apr 2025 10:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qtKtxh88";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L4k4ICgH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0994F4690;
	Thu, 10 Apr 2025 10:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744282734; cv=none; b=EtrP0TOJ+uwUfhXjTXov/t8fZU4sKwuKt45+QNnb+vwwBbSFhBAGBuBj1whdDMorEJpGJzBFye4wVhhhlyUPAEL4eJ4+FvyZCQWG27GSfEBSvLTc4GjZKbP8pbSnkdMKQuABzIeCw3vkxd+HBvBoTtGO5OSd95tF7pj21wGduUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744282734; c=relaxed/simple;
	bh=I85KrcPVNbeEsFqHofgSAfg3Fa6FXvobyZxNEDeG1Mg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=El7As5W/hGvWBtlibSqPp2FtRsEAwaS9LRYBJBQB4z8G9xmJcxRUSoWbrTJT6FMZn9cPXv6HV9ufhhJbLsFteG0O4lvChH2+rj6m7xTeGo77HY0qHqfwAS20+WeYsz4RSp0LksomhKcXTCWFewdD27AvYTscTbU5uKxCT80mCz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qtKtxh88; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L4k4ICgH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Apr 2025 10:58:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744282730;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j4Cu69QuKLGxsMceHEWHe2OF18dV3H/L1mMneAY1InM=;
	b=qtKtxh88oy//MTYQ9Wq2xizGzXelifOOVYFjtocqWlbOeGS/Pog56lXnQ4XS7WOZ6KGUbw
	6DT/ct/JpkFoJ2A5Y8QhFnazeJE+uWx2sWCUtsZOHpIUVkGJonJDEF62YMFW+t6NQ2xc5L
	KUMkkhSxbnmYTAQdPlUIcXYDwOG59DQmxl7ocXwxC5cPxWmv4FixTS9xNaKhgPQ0XrG9hY
	2w8vAL6avCgbqNLVhFDbGnpHrNRD8zx6f35OD6ULarVvTIVNnok1QKVETbssQzpDrKDIC0
	qfa9+PmNtC3/dYfu99pJ8Ky+ZYsP9e28Zj/GKR5KlHXT6aOibc455Jz7lpXkvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744282730;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j4Cu69QuKLGxsMceHEWHe2OF18dV3H/L1mMneAY1InM=;
	b=L4k4ICgH5mNw7ojtE+N2DU68icP8q1I15D/rcp0DfRrdNmavRoa2I3ATkklQQg+Fycxl0E
	aQ7sEUFuD1XJ80Bg==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/urgent] compiler.h: Avoid the usage of __typeof_unqual__()
 when __GENKSYMS__ is defined
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Uros Bizjak <ubizjak@gmail.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250404102535.705090-1-ubizjak@gmail.com>
References: <20250404102535.705090-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174428272631.31282.1484467383146370221.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     e696e5a114b59035f5a889d5484fedec4f40c1f3
Gitweb:        https://git.kernel.org/tip/e696e5a114b59035f5a889d5484fedec4f40c1f3
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Fri, 04 Apr 2025 12:24:37 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 10 Apr 2025 12:44:27 +02:00

compiler.h: Avoid the usage of __typeof_unqual__() when __GENKSYMS__ is defined

Current version of genksyms doesn't know anything about __typeof_unqual__()
operator.  Avoid the usage of __typeof_unqual__() with genksyms to prevent
errors when symbols are versioned.

There were no problems with gendwarfksyms.

Fixes: ac053946f5c40 ("compiler.h: introduce TYPEOF_UNQUAL() macro")
Closes: https://lore.kernel.org/lkml/81a25a60-de78-43fb-b56a-131151e1c035@molgen.mpg.de/
Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
Link: https://lore.kernel.org/r/20250404102535.705090-1-ubizjak@gmail.com
---
 include/linux/compiler.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 27725f1..98057f9 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -229,10 +229,10 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 /*
  * Use __typeof_unqual__() when available.
  *
- * XXX: Remove test for __CHECKER__ once
- * sparse learns about __typeof_unqual__().
+ * XXX: Remove test for __GENKSYMS__ once "genksyms" handles
+ * __typeof_unqual__(), and test for __CHECKER__ once "sparse" handles it.
  */
-#if CC_HAS_TYPEOF_UNQUAL && !defined(__CHECKER__)
+#if CC_HAS_TYPEOF_UNQUAL && !defined(__GENKSYMS__) && !defined(__CHECKER__)
 # define USE_TYPEOF_UNQUAL 1
 #endif
 

