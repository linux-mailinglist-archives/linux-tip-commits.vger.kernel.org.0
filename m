Return-Path: <linux-tip-commits+bounces-7156-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E8AC28761
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27A7B4EFA02
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CD43101C0;
	Sat,  1 Nov 2025 19:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dyql9NLH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d1poVW/d"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D703C30F929;
	Sat,  1 Nov 2025 19:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026488; cv=none; b=F+4kxW5+jEXVyEjz1cPS0ax1nsXPrfSKcQbXPmyt5OfHWOWJUZPOkDElwoAHcAbDjLfjfpjCYaxg1sL1tFteWZEOBQnj6Zil8+O0LsdAHvURvK/4N5zmbXMA/LgvHP6pNiiM5prbfkiiNdwo3fzF/fpS8qah3WMph2syqAd6BCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026488; c=relaxed/simple;
	bh=Z2nhhA/UzejpVyDjMagoI5MHS2lnC+hy3GFf+/ULq6k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=faehxGLrc/Ptq6iA8xw+EKuryVZ6toDef7Dhl50XdzKzon3mQC/8A8J8IXrVNF2FxqTsVWZNLmW6aTqkin94tS8uOaXnRYWxRJkSos9MqOWCCF0KP358DyblEvEnEVU63zSGudYzWlbGn/tj9ZPKIUaNR+voV7Hga1A9USpaNSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dyql9NLH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d1poVW/d; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:48:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026485;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7MpF7JA1wbSheMbc2P+6kOdkiPOe9udOz4Bzr1WCKvo=;
	b=Dyql9NLHkBN8TfRjHp4CAn6u+wI9nYcGBVVgwiG179ROWFdY0Wkfwjx3MpyXW9i0qG27qx
	Afdb/slCRaAL04Hj2FHKFw+QQ3zP1X2IkK3a4tk6jwBm71qUfohYprmPM2/yYl0YiatXPq
	Pja4kQfnjaf8s4Sf8iHRIV2ZaKFJ3npj7sxF+uz4HvPJai2SzCRkJVM94MpivmNVsgiZe+
	sgVSu8GkR76Kznfo36dWyWfkst3f62FWJdJKzIKhp2R7BfEgjSKhaSHY/mVI7kVGT8rywy
	xDC5DcS6m5yQgtRGF8dJTw33AsjMwXJqBmX51zma1SkOr7nCUUK9Bo427FgFbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026485;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7MpF7JA1wbSheMbc2P+6kOdkiPOe9udOz4Bzr1WCKvo=;
	b=d1poVW/dnrGvJOx9V5XrWdyoXGhomx9dBhyNUWtymJtMjCE2R8nlyTWv2wJMh9tWc3J1FI
	Etmig93NbSy9UdDA==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] MIPS: vdso: Explicitly include asm/vdso/vdso.h
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Andreas Larsson <andreas@gaisler.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20251014-vdso-sparc64-generic-2-v4-10-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-10-e0607bf49dea@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202648427.2601451.12572632458165063986.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     26f8d33364ce7fa9c199f98d6fc4285c70b29db8
Gitweb:        https://git.kernel.org/tip/26f8d33364ce7fa9c199f98d6fc4285c70b=
29db8
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 14 Oct 2025 08:48:56 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:44:03 +01:00

MIPS: vdso: Explicitly include asm/vdso/vdso.h

The usage of __VDSO_PAGES requires asm/vdso/vdso.h. Currently this header
is included transitively, but that transitive inclusion is about to go
away.

Explicitly include the header.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Link: https://patch.msgid.link/20251014-vdso-sparc64-generic-2-v4-10-e0607bf4=
9dea@linutronix.de
---
 arch/mips/kernel/vdso.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
index de09677..2fa4df3 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -21,6 +21,7 @@
 #include <asm/mips-cps.h>
 #include <asm/page.h>
 #include <asm/vdso.h>
+#include <asm/vdso/vdso.h>
 #include <vdso/helpers.h>
 #include <vdso/vsyscall.h>
=20

