Return-Path: <linux-tip-commits+bounces-7952-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1F6D192E7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 14:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BF0A30B4703
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 13:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7C0392801;
	Tue, 13 Jan 2026 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L8OCCpaU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ddJ25FiI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9761B4F09;
	Tue, 13 Jan 2026 13:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768312061; cv=none; b=bYbeh2Jk0FsS3oCgVqln477IqmmCdGPC6/m5v2/NrLy8sWLJGMWDIkSdPZnj/gYD75qbMR5ogkcLfNaS76/pyA0xfWVGDBK0Ih6jkRwoWS+5M61MHC/aW0tWfWOltY8UxF8smvxdIIEXqVSZwr3/gPejstcXzN1otdLHo8eayFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768312061; c=relaxed/simple;
	bh=5vicGRjl9Bv0O/n66yZxmNWe9r+bg4bZ/kKR7Xp9OZ4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CdjBft9dAnq5bQGLafapWN/Q/RhbOClODstETZj5yZIl7rAjKKnbg2YOUwQeL+cftaLWutJeyyY26UJ3F5akI2Lx8PejgPmSvGfjwpe6xaCChCvykMN+FGu60LXTcY8oxiyDWSLfRWa2iNUZ1DI4dFfcNhrHat8XyXO8OXGYWg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L8OCCpaU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ddJ25FiI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 13:47:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768312057;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZGH3AHy+28cu8/jZ4CXGQyYuy5h1NyP1SMtTnnlfOIs=;
	b=L8OCCpaURTkJOQweKplkRQWIAQJGw+WmMIGXZeJNP1AWwIOR0lIr2CrsfZV6sRlnJniGcz
	gISkVRMPjq/8nHpoDZTwijl8UGZ+Ahx+lXkC1IRuedgCspYLihdDANsmPvzRhR8zwrNMoz
	pjj5pLbSFKetnhXxjaAjzUjvAv9Y0mP5hnz6eUxpRHehzEmavjXCy9eVs9etTm+LM3mbjd
	1vcLBBTvmudN9fzowRMmfR4dsxjFtsnv9UMw05u+bYRPYIFKe0aTjYQAcr6/Gu58sqZMlX
	o6h5MB07WHazjZ4HBmOvpi7LDWO8IYypOsCZUV1+spvhu70LQnlUxZJKhNKExQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768312057;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZGH3AHy+28cu8/jZ4CXGQyYuy5h1NyP1SMtTnnlfOIs=;
	b=ddJ25FiITih94D4I2R79HgHYi0QhsXangbGxb7Bc4R2Y2cjlCN+2b80iTS/EaGpXb5r2Qr
	NrYa5c0WpBxGhcBg==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] ARM: VDSO: Patch out __vdso_clock_getres() if unavailable
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251223-vdso-compat-time32-v1-6-97ea7a06a543@linutronix.de>
References: <20251223-vdso-compat-time32-v1-6-97ea7a06a543@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176831205636.510.15209513100171029423.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     b9fecf0dddfc55cd7d02b0011494da3c613f7cde
Gitweb:        https://git.kernel.org/tip/b9fecf0dddfc55cd7d02b0011494da3c613=
f7cde
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 23 Dec 2025 07:59:17 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 13 Jan 2026 14:42:23 +01:00

ARM: VDSO: Patch out __vdso_clock_getres() if unavailable

The vDSO code hides symbols which are non-functional.
__vdso_clock_getres() was not added to this list when it got introduced.

Fixes: 052e76a31b4a ("ARM: 8931/1: Add clock_getres entry point")
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20251223-vdso-compat-time32-v1-6-97ea7a06a543@=
linutronix.de
---
 arch/arm/kernel/vdso.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index e38a304..566c40f 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -161,6 +161,7 @@ static void __init patch_vdso(void *ehdr)
 		vdso_nullpatch_one(&einfo, "__vdso_gettimeofday");
 		vdso_nullpatch_one(&einfo, "__vdso_clock_gettime");
 		vdso_nullpatch_one(&einfo, "__vdso_clock_gettime64");
+		vdso_nullpatch_one(&einfo, "__vdso_clock_getres");
 	}
 }
=20

