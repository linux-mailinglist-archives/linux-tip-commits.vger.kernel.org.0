Return-Path: <linux-tip-commits+bounces-2950-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539AE9E0099
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A0B6286BE6
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F257E20ADF6;
	Mon,  2 Dec 2024 11:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RGf59SWm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LFKN+2Nx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFE720ADD2;
	Mon,  2 Dec 2024 11:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138623; cv=none; b=BL8Qe30FqF4Tg6wmibItbXUddBjUAEPrK9+WonzG/nJy/DfLnNEE9ZAc7sD2wf8fGZb8Mex/8VYuNPhO+dGfYxc3txIg4+51FDbOJwQBMktVPioUVmu/M9G3Ht+Wx6EbeVAN8Igw69HWd7xDdpv1ift5vvuGfNZs8biv3h8oGGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138623; c=relaxed/simple;
	bh=RhEWroN15efPRkhwf6k19OTy265Ehw+OEHGDDSy5jOA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OQeT9AazuRlXqmXAWm1FELqi3TPXlq2vdOJi7FBdcj8Qvl4F5o5sgKwb6G8V5r0LrgMQNMuiy4DNDzrHIPuHiwphmp8Nz1Wdu7Q9SbRwln58TjIIzb1tmaFPn11LrrgiR7nzTadl3rcpT+uJqPEZmoEj8EUTJWdRWhIpaReMER0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RGf59SWm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LFKN+2Nx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:23:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138614;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fP3f98ARfzf022tqcgTyQ6nE0SvBrAZnzI/mJ53nejw=;
	b=RGf59SWm/QRSyNlU/wISv9e+zHrCKlgK0hgf6eBOQQ50TmgxCRFJI1f7YyJaSfVg3a0OG7
	hGDrIEE7zQzw+V54iSWKj+W4K1lr2KDH1N7+WThpXxlh3Yi6BdrK00B1BhSc1NMefB5kyF
	TO/H0YNWl5S/CNZZBJHxZ0ARDcaXZR+6zCpAuK7XfQ66paDBeMVhytWb0fTSOQeuJQtPPN
	zBJ1dmwrckEQfscBbWY4F5CY2mtNJFAdtHycZmLq6uZJdm78aBz8JtklkQRZuXKCF6AWjx
	biw3Sj0YAG6ARzBxxdt7ou+HXHeoZcXslRnWqdSl6rMB9UUsZIaYaE73TqWBig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138614;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fP3f98ARfzf022tqcgTyQ6nE0SvBrAZnzI/mJ53nejw=;
	b=LFKN+2NxTeFEc/msmuD4sa1/0lh6/3+VFuJ7qB2E8GQsl7ZGxxNDOdG7O3WYXprFQNFePg
	VYvqfhYID7wrVBAw==
From: "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/lockdep: Enforce PROVE_RAW_LOCK_NESTING
 only if ARCH_SUPPORTS_RT
Cc: Guenter Roeck <linux@roeck-us.net>, Waiman Long <longman@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241128020009.83347-1-longman@redhat.com>
References: <20241128020009.83347-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313861411.412.6467281091993873078.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     d387ceb17149fed4d85a1ec01b3d65ae0204060d
Gitweb:        https://git.kernel.org/tip/d387ceb17149fed4d85a1ec01b3d65ae0204060d
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Wed, 27 Nov 2024 21:00:09 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:16:58 +01:00

locking/lockdep: Enforce PROVE_RAW_LOCK_NESTING only if ARCH_SUPPORTS_RT

Relax the rule to set PROVE_RAW_LOCK_NESTING by default only for arches
that supports PREEMPT_RT.  For arches that do not support PREEMPT_RT,
they will not be forced to address unimportant raw lock nesting issues
when they want to enable PROVE_LOCKING.  They do have the option
to enable it to look for these raw locking nesting problems if they
choose to.

Suggested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20241128020009.83347-1-longman@redhat.com
---
 lib/Kconfig.debug | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f3d7237..49a3819 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1397,9 +1397,9 @@ config PROVE_LOCKING
 	 For more details, see Documentation/locking/lockdep-design.rst.
 
 config PROVE_RAW_LOCK_NESTING
-	bool
+	bool "Enable raw_spinlock - spinlock nesting checks" if !ARCH_SUPPORTS_RT
 	depends on PROVE_LOCKING
-	default y
+	default y if ARCH_SUPPORTS_RT
 	help
 	 Enable the raw_spinlock vs. spinlock nesting checks which ensure
 	 that the lock nesting rules for PREEMPT_RT enabled kernels are

