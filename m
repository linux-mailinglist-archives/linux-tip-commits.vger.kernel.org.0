Return-Path: <linux-tip-commits+bounces-7896-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E66D17E00
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC4203000DC3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BE43876D1;
	Tue, 13 Jan 2026 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G0QKCUsA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rF+FnAeF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE3F3624B9;
	Tue, 13 Jan 2026 10:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298816; cv=none; b=JdSrxMkRBp2Bfj8weY0hjdRVWQ1L9A6P1vUmIU7vo2AhEn7EM7fzrigjfAk9FUPERMrqFpjXLZ+LcW9CVG7v3hyrIhKOIkKLY6JLVclpbp+rtR0QB8ZlNkphJ9bNqn5htzp4CH9orUCj76imEOg7LsaBSXk4Y3gaajwnSSLD3z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298816; c=relaxed/simple;
	bh=iFC5xjQxxnzl8jhkhFzM6EAQzioC6xNW4/oztPomu/U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KDIVzrMTo6yYDTCiO3RWyhPG0ad4sdV4NyI6INWR5w6B3j6aG30nXpg9zQYu2xFHD1ym6/yKcS0yc+yHrZRNVc5K5mMGCBJ61GrDflNmgLYRZvzsJDm3WLsyeqhNIuBCUfUOXuiv07TrsT0EJos1fUpbaIY+/NGOekHBDYVQnLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G0QKCUsA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rF+FnAeF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:06:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768298812;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2pRJP9TXwFnPi4m1xP77qO/0+eCorLPISJamp+A514A=;
	b=G0QKCUsAhLjqNDG2OFfUY92wqkmhOa5QZ9FK5uaVanttQL9pqF0SBh1f2rNJAqGp1QN0SQ
	qcBUlPjg2+kSy0rw3+2CyzdQKGUO9PtQCha6kMOV3CVn1z+78JbpvrHjkMFWK3X9d6zuW0
	P0jwS/2wPgrsOS00m9p3XE8O0NS+y6Pp+Sp7DbpQeJwAq2j9qVcde7ESbWQyUUTLfCiqWf
	I96l+uI2enj/GbAsJFd/82gDldcMsEJfL/HOGOdMsJBlSzWYf2ICxcxSPDl/E8Ka0x5ppa
	yP83bJlZ//pvVNkbJwiJgaQWpnRDGZAPEQ/DYn12aphz8QmOtwanDlnoNYTkBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768298812;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2pRJP9TXwFnPi4m1xP77qO/0+eCorLPISJamp+A514A=;
	b=rF+FnAeFLxcfGGxMtRq4p1QSr5n+7Mc6RzwiIVqR/hHSnmh+8pXgqwYaDimYaTOl2QL7Lt
	bHYkNpXLt2zzFsDQ==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimer: Remove unused resolution constants
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260107-hrtimer-header-cleanup-v1-1-1a698ef0ddae@linutronix.de>
References: <20260107-hrtimer-header-cleanup-v1-1-1a698ef0ddae@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176829881104.510.17467502692321423390.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     0483e5e1dc78f53c540b19231e9cf5571ce01d50
Gitweb:        https://git.kernel.org/tip/0483e5e1dc78f53c540b19231e9cf5571ce=
01d50
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Wed, 07 Jan 2026 11:36:56 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 13 Jan 2026 11:05:48 +01:00

hrtimer: Remove unused resolution constants

These constants are never used, remove them.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260107-hrtimer-header-cleanup-v1-1-1a698ef0d=
dae@linutronix.de
---
 include/linux/hrtimer_defs.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/linux/hrtimer_defs.h b/include/linux/hrtimer_defs.h
index aa49ffa..e0280d8 100644
--- a/include/linux/hrtimer_defs.h
+++ b/include/linux/hrtimer_defs.h
@@ -15,14 +15,6 @@
  * this resolution values.
  */
 # define HIGH_RES_NSEC		1
-# define KTIME_HIGH_RES		(HIGH_RES_NSEC)
-# define MONOTONIC_RES_NSEC	HIGH_RES_NSEC
-# define KTIME_MONOTONIC_RES	KTIME_HIGH_RES
-
-#else
-
-# define MONOTONIC_RES_NSEC	LOW_RES_NSEC
-# define KTIME_MONOTONIC_RES	KTIME_LOW_RES
=20
 #endif
=20

