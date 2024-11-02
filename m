Return-Path: <linux-tip-commits+bounces-2738-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F129B9FAE
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 12:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AC101C20B69
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84EE1ABEC9;
	Sat,  2 Nov 2024 11:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NGJIEcYW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mgAZ8/KI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189041AB500;
	Sat,  2 Nov 2024 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730548226; cv=none; b=GcnwMzM6erRYUs9HbTkJ5gYj7EUnPoL/FEY0yrEoxtmMy2UonSJj+c2rRwwbaRQP/zRcY044cz9O1sWcKgYvDuxubqkkXX7jTUb9IdKq+erBOGBvR9+H1P7onzzNUt93wANPN/puhswS6c5PgA1cWPkp40Vgre7kIcQongrueQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730548226; c=relaxed/simple;
	bh=pNwi9dRMy5zH+LKbGozC8C3jnkNWiltfrRqiT1A/Aus=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VmZBzBFmvwlSIfi5u7LCBs0FqljL20LtfpKNFAx0BtIp+w1Q/kmQm2qjOrncm64R8JFbCiYcFdiCuEZY2aklFb7b8S6xlTEOqiwZ3p5ejfoHikBmyauRxbr4l/NsEkPLzfrH0JUS7xVD+1eaK62O8LwKYUoGMQ2lnR2LiCKJb8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NGJIEcYW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mgAZ8/KI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 11:50:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730548223;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=trbqLYtP8WSnG4KciFz+WmXu6qOHzFhfnjoGI43RNqM=;
	b=NGJIEcYWht/yePAM6V9SRfWkdHHVr/Y2mGEAz/qVOKnySEDOE6SKPT3K3+yyaRYRmThvhb
	G0CvfUpn4O4yH2oU3kmQ7NpvdOufwmidoCS0ShApI1J7cCVSs32YUYKtWO+eqXT3Nl4cRm
	8xTkWnpl0CpaktouiJEqObjxthnj/SAdq96LZkklg+/Ju7f1POKo2i3ze1RKpiNRKIS09A
	Hbi3tXwHJkEWiC/3/gq4R4S9WreUUfOcNaBr4n9mDe1rr2hpB4LrCxbBey+O1KFnjnD64n
	EfcXj3K5bWnkZfoTY5HiZjOkk8iRrn+XoLn/9IN5kWB7+9cI/ddn7CEePDlirg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730548223;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=trbqLYtP8WSnG4KciFz+WmXu6qOHzFhfnjoGI43RNqM=;
	b=mgAZ8/KIbr1ZRcyvHfzIAxtJ0jIJV7N+d/hhznEvPv7Kq5r7sPK3AefjCARyJ899/6DeAe
	DmYhaAu6JaT3yBDg==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] x86/vdso: Place vdso_data at beginning of vvar page
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241010-vdso-generic-base-v1-12-b64f0842d512@linutronix.de>
References: <20241010-vdso-generic-base-v1-12-b64f0842d512@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173054822299.3137.17992699633057257160.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     9f8514cfcdf0d929e2d3d440c0d4991f16b7e53b
Gitweb:        https://git.kernel.org/tip/9f8514cfcdf0d929e2d3d440c0d4991f16b=
7e53b
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:14 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 12:37:34 +01:00

x86/vdso: Place vdso_data at beginning of vvar page

The offset of the vdso_data only has historic reasons, as back then
other vvars also existed and offset 0 was already used.
(See commit 8c49d9a74bac ("x86-64: Clean up vdso/kernel shared variables"))
Over time most other vvars got removed and offset 0 is free again.

Moving vdso_data to the beginning of the vvar page aligns x86 with other
architectures and opens up the way for the removal of the custom x86
vvar machinery.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241010-vdso-generic-base-v1-12-b64f0842d5=
12@linutronix.de

---
 arch/x86/include/asm/vvar.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/vvar.h b/arch/x86/include/asm/vvar.h
index 9d9af37..01e60e0 100644
--- a/arch/x86/include/asm/vvar.h
+++ b/arch/x86/include/asm/vvar.h
@@ -58,7 +58,7 @@ extern char __vvar_page;
=20
 /* DECLARE_VVAR(offset, type, name) */
=20
-DECLARE_VVAR(128, struct vdso_data, _vdso_data)
+DECLARE_VVAR(0, struct vdso_data, _vdso_data)
=20
 #if !defined(_SINGLE_DATA)
 #define _SINGLE_DATA

