Return-Path: <linux-tip-commits+bounces-7140-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EF8C286FE
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD0A1A212A0
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415F230748E;
	Sat,  1 Nov 2025 19:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m0ri56jo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TOX+7zHW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C87305E01;
	Sat,  1 Nov 2025 19:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026470; cv=none; b=hM4IHzQEjSP2Q6fyzqsii+kS6c54dqz29zJ9/7JotlD8dHtSRo8T+Fct3Ta8MEL7skyLS16yZJ/AoBtQAw+mrFEnA7muL8jXqRYJ4dcBnqkfwg9WNP8iJLe5JeE+ownV7eHfFWXrah65cDVOoa8v37O/y4KiAjKiYJ7zrOFzLIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026470; c=relaxed/simple;
	bh=E6PuqwOwfkrDeHN8BXlxb9JkFYIvqCi/t9sygWWcWhA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BYaXN6PX2fVp/BUu7kJzUXLKuOJo4ya/ivCwtZ2oqWKgG7Xc+K2OjjSEAxQRiwGNI/o4MCLYIINbFUPti4eZAb8RdQ6buMMru0hrYAfGR/Q519PkAFB4zhFoNz7a5EPI1QBoXm9ZWk4Ce3XRx8kqh7xbX/znhHie1X3V858RJ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m0ri56jo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TOX+7zHW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:47:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026465;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9jDzkXu4xZmRzIwsmkNrHMSv3BxKD47WqzNFlHNMZbM=;
	b=m0ri56jog4V6rDn83jH6Z+KmyJnionb+ozCS0Hp3wwK87LN2zXbUkxkqrWnkxZBAFx34LP
	MLTabZmxZaraNfdTMQAxryN8wiTQ7x9juT7ylvW+1je8k0IWIa/v6Cv2X8LAD/N34j9zi7
	Shnv7TSFSV5rwDEmwlk/laZr/2H1X47FvhQX60pWlIq3vhKRTl6ToGMcE0ETBrBq6AhR5H
	xxMcY9aL7lOS/Ad9zxOEhE2oFoJMvVkhwCr3ovNMD3DkDaSSUgAwk2knxFoCb7PkFlFNou
	p++VEOY8KEcMUV15/UNGfcM+sJ2iM2JIx5MK4tXPyddTGdzI35ZJJl6nMnNGJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026465;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9jDzkXu4xZmRzIwsmkNrHMSv3BxKD47WqzNFlHNMZbM=;
	b=TOX+7zHWYZ7qgs3d5SkFO/YFDNmBaL1FPpPWQy1O5DSUa+9XjPfOQrR5ao2PiYwyRkGcCQ
	e3uYjl+iLz5ZVJAg==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] sparc64: vdso: Remove obsolete "fake section
 table" reservation
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Andreas Larsson <andreas@gaisler.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20251014-vdso-sparc64-generic-2-v4-26-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-26-e0607bf49dea@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202646052.2601451.14687253507395404051.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     ec1b6750438b214c140051572cd9ee429ee7280a
Gitweb:        https://git.kernel.org/tip/ec1b6750438b214c140051572cd9ee429ee=
7280a
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 14 Oct 2025 08:49:12 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:44:07 +01:00

sparc64: vdso: Remove obsolete "fake section table" reservation

When the vDSO logic was copied from x86 to SPARC some unused remnants of
the fake section handling were copied, too. In x86 the original fake
section handling had already been removed incompletely in commit
da861e18eccc ("x86, vdso: Get rid of the fake section mechanism").
On x86 the reservation was only cleaned up in commit 24b7c77bbb24
("x86/vdso: Remove obsolete "fake section table" reservation").

Remove the reservation for SPARC, too.

Fixes: 9a08862a5d2e ("vDSO for sparc")
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Acked-by: Andreas Larsson <andreas@gaisler.com>
Link: https://patch.msgid.link/20251014-vdso-sparc64-generic-2-v4-26-e0607bf4=
9dea@linutronix.de
---
 arch/sparc/vdso/vdso-layout.lds.S | 21 ---------------------
 arch/sparc/vdso/vdso2c.c          |  8 --------
 2 files changed, 29 deletions(-)

diff --git a/arch/sparc/vdso/vdso-layout.lds.S b/arch/sparc/vdso/vdso-layout.=
lds.S
index d31e57e..9e08047 100644
--- a/arch/sparc/vdso/vdso-layout.lds.S
+++ b/arch/sparc/vdso/vdso-layout.lds.S
@@ -4,16 +4,6 @@
  * This script controls its layout.
  */
=20
-#if defined(BUILD_VDSO64)
-# define SHDR_SIZE 64
-#elif defined(BUILD_VDSO32)
-# define SHDR_SIZE 40
-#else
-# error unknown VDSO target
-#endif
-
-#define NUM_FAKE_SHDRS 7
-
 SECTIONS
 {
 	/*
@@ -47,19 +37,8 @@ SECTIONS
 		*(.bss*)
 		*(.dynbss*)
 		*(.gnu.linkonce.b.*)
-
-		/*
-		 * Ideally this would live in a C file: kept in here for
-		 * compatibility with x86-64.
-		 */
-		VDSO_FAKE_SECTION_TABLE_START =3D .;
-		. =3D . + NUM_FAKE_SHDRS * SHDR_SIZE;
-		VDSO_FAKE_SECTION_TABLE_END =3D .;
 	}						:text
=20
-	.fake_shstrtab	: { *(.fake_shstrtab) }		:text
-
-
 	.note		: { *(.note.*) }		:text	:note
=20
 	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
diff --git a/arch/sparc/vdso/vdso2c.c b/arch/sparc/vdso/vdso2c.c
index dc81240..b97af5e 100644
--- a/arch/sparc/vdso/vdso2c.c
+++ b/arch/sparc/vdso/vdso2c.c
@@ -61,8 +61,6 @@ const char *outfilename;
 /* Symbols that we need in vdso2c. */
 enum {
 	sym_vvar_start,
-	sym_VDSO_FAKE_SECTION_TABLE_START,
-	sym_VDSO_FAKE_SECTION_TABLE_END,
 };
=20
 struct vdso_sym {
@@ -72,12 +70,6 @@ struct vdso_sym {
=20
 struct vdso_sym required_syms[] =3D {
 	[sym_vvar_start] =3D {"vvar_start", 1},
-	[sym_VDSO_FAKE_SECTION_TABLE_START] =3D {
-		"VDSO_FAKE_SECTION_TABLE_START", 0
-	},
-	[sym_VDSO_FAKE_SECTION_TABLE_END] =3D {
-		"VDSO_FAKE_SECTION_TABLE_END", 0
-	},
 };
=20
 __attribute__((format(printf, 1, 2))) __attribute__((noreturn))

