Return-Path: <linux-tip-commits+bounces-7558-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 777D6C93098
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Nov 2025 20:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D8FDA3480FA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Nov 2025 19:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1272BF006;
	Fri, 28 Nov 2025 19:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m3Nd01k3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/fh20gj6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEA7255F31;
	Fri, 28 Nov 2025 19:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764358949; cv=none; b=UHlDAZv7pkSaS3eIJ71J6pLM6LsAUWLtIE2puHVJIaXLvhKCOB/S005DpeFgDyT1fPRYlyA0vpdV03nYt4dMSzQHWfbKYRcomw2iPVN9/9EwhB9K9JPaSXgb0fx9AX9Zw9NiHz3LuPsFnXlo8GALjJk3YIwrzdcxOCBObgxANSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764358949; c=relaxed/simple;
	bh=3vlRWcfeUaigBdf4OZgRAzOaTXBvu6rBP8cFpPf3O6E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=U0MYgo45SaAPS/B3nwcNdtGKq3dJ6Vd8ghQabqoYmBg6F3KTEWKrDZ66Xa0MrHtLLSjOiQnoCDS3WDGPnx3fqKxr4hxRbapTLKBjfB3pXY2HjFwUcyco742jyYqL3IqLaU9JVowSgb6dPl23+JEnfYPabwjtZn/Y9Sj1wEZaf28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m3Nd01k3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/fh20gj6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 28 Nov 2025 19:42:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764358945;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A4C5Jy8DjTz7LWYGCdZO3dm1Exy+XUlmw761NjaYfSY=;
	b=m3Nd01k360Xw6tZvPSqaX2aOurtegTNjMLcWjCc/oiTBCWfembrZ4azUmj8OWrlmJ2ydTi
	7dfcXMHGnsakOhqqFG0mFPhVvEOI1umQQd9BCHa5y8ItgsZIZIbbZauY21A+GjAoMq7PDI
	vmJej8PhT/9N+4tMyWsuyn5uGDiN53o9KBpNKRf1Lf0lv9K27guSPjYCdbr8ClD4kFltWg
	0cltrFrJjA+kTW6p5wyuUQkOxT0c2P1YDpoXN9c8r9p7hzahEL/2k3rFWJaJ4TABqBs+O0
	ptEgd7+IQfEWvpkvxlC3el9lxAnvxzDzpTgJbi5W6tFWK+IxTw2doc3qy7gXwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764358945;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A4C5Jy8DjTz7LWYGCdZO3dm1Exy+XUlmw761NjaYfSY=;
	b=/fh20gj6vbMZkPk25V4tKmhhs8KfyibZt/Z3h9i0/SJaQFjuxIkveZyXJx7TX3OQAfic+r
	DOT7fHEsgpPVgsBw==
From: "tip-bot2 for Harry Fellowes" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/boot: Clean up whitespace in a20.c
Cc: Harry Fellowes <harryfellowes1@gmail.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250825192832.6444-3-harryfellowes1@gmail.com>
References: <20250825192832.6444-3-harryfellowes1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176435894400.498.7473875584362106376.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     d911fe6e942e60900577314dc1f1529b90e4da07
Gitweb:        https://git.kernel.org/tip/d911fe6e942e60900577314dc1f1529b90e=
4da07
Author:        Harry Fellowes <harryfellowes1@gmail.com>
AuthorDate:    Mon, 25 Aug 2025 20:28:34 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 28 Nov 2025 20:29:52 +01:00

x86/boot: Clean up whitespace in a20.c

Remove trailing whitespace on empty lines.

No functional changes.

  [ bp: Massage commit message. ]

Signed-off-by: Harry Fellowes <harryfellowes1@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20250825192832.6444-3-harryfellowes1@gmail.com
---
 arch/x86/boot/a20.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/a20.c b/arch/x86/boot/a20.c
index a2b6b42..bda0429 100644
--- a/arch/x86/boot/a20.c
+++ b/arch/x86/boot/a20.c
@@ -135,29 +135,29 @@ int enable_a20(void)
 		  (legacy free, etc.) */
 	       if (a20_test_short())
 		       return 0;
-	      =20
+
 	       /* Next, try the BIOS (INT 0x15, AX=3D0x2401) */
 	       enable_a20_bios();
 	       if (a20_test_short())
 		       return 0;
-	      =20
+
 	       /* Try enabling A20 through the keyboard controller */
 	       kbc_err =3D empty_8042();
=20
 	       if (a20_test_short())
 		       return 0; /* BIOS worked, but with delayed reaction */
-=09
+
 	       if (!kbc_err) {
 		       enable_a20_kbc();
 		       if (a20_test_long())
 			       return 0;
 	       }
-	      =20
+
 	       /* Finally, try enabling the "fast A20 gate" */
 	       enable_a20_fast();
 	       if (a20_test_long())
 		       return 0;
        }
-      =20
+
        return -1;
 }

