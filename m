Return-Path: <linux-tip-commits+bounces-7159-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B05C28770
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26A674F44D2
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9E63126D2;
	Sat,  1 Nov 2025 19:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qn4caMKd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LHVwKP5J"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE904311976;
	Sat,  1 Nov 2025 19:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026492; cv=none; b=r2lTP9nMMZvOIzaX2xwFHXVkGc9uP8uIVYSbBpsDlMYB/vxdD5c+C2sGJ4aC73MH/d38oQWH8hmpGMPjGXlvpVERE9nCM1ARs3HKSSyIpt1pib97HGa8MyWVObqhAVmAWMomKiCob8S8Azu7xeSH/GTpoUgdD6AWK54BUhHephA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026492; c=relaxed/simple;
	bh=C8mSHnZcwJWhBsR1zSsTqlmXypoVjWsLy2QH5BxiXfQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XClcPgTsnv4B54aRWPqudPX0cn0HflxviQ7usb/NKg0IF1BMYeLmkeWVQgqaiCOrV3rqYsPK+5ruvMjP/bSXMxdJjj64ifhdlUmO0y7xu+hsUVehL37CBMxYMR5ooiXFsRMiW1vVo5OLJbV3Nsfi29xmuPlUnoGsp2on860IGUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qn4caMKd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LHVwKP5J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:48:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026489;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V/44aod42YQNCSmlcqJY+2QL/f/ybfRjlOQKDcRKlTE=;
	b=Qn4caMKdu3V+qFU2hs0ft/3z1ZSBj2n6W8PtQFYjw2vZkxInvrcPiRe7JNYzecLASp0qTm
	NoN+bC6NNhM0XoBw6BpUPLgm6a8uFbNGMKJTMZ5W+UTIJjsZ9jslywNW/S1JZ/yxJWc80O
	MGA1lm5PFJwCeGVRDPwcv0tRLrsaxtOF7g+icGYFIYuFQJuyEZ/3HXE16FPo2fEeadTTwx
	hdJejBAd4ulg2QTsmy8X7U2M4onV4/rbUqtyZBaxwzVGpKxBzgd/mPbQzXLIq50Vwg63Y4
	gBkv6bHWGeLJmjV0l+dVoCT7+mSCKTo+gSSh77fxan67rYFMju4EVfgpR0/osQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026489;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V/44aod42YQNCSmlcqJY+2QL/f/ybfRjlOQKDcRKlTE=;
	b=LHVwKP5JOqTOiuT+8hNsueSbvx4lF84KbCxjRehkKTIm+Zn6MBobZl+vXuicgCSYZAurf+
	j4Qo4TwdYzuTOPBQ==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] powerpc/vdso: Explicitly include asm/cputable.h
 and asm/feature-fixups.h
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Andreas Larsson <andreas@gaisler.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251014-vdso-sparc64-generic-2-v4-7-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-7-e0607bf49dea@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202648801.2601451.5679266645119551372.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     638ca04753695ea912be97dd69e13cb28fe2f060
Gitweb:        https://git.kernel.org/tip/638ca04753695ea912be97dd69e13cb28fe=
2f060
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 14 Oct 2025 08:48:53 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:44:03 +01:00

powerpc/vdso: Explicitly include asm/cputable.h and asm/feature-fixups.h

The usage of ASM_FTR_IFCLR(CPU_TR_ARCH_31) requires asm/cputable.h and
asm/feature-fixups.h. Currently these headers are included transitively,
but that transitive inclusion is about to go away.

Explicitly include the headers.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Link: https://patch.msgid.link/20251014-vdso-sparc64-generic-2-v4-7-e0607bf49=
dea@linutronix.de
---
 arch/powerpc/include/asm/vdso/processor.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/include/asm/vdso/processor.h b/arch/powerpc/include=
/asm/vdso/processor.h
index c1f3d7a..4c6802c 100644
--- a/arch/powerpc/include/asm/vdso/processor.h
+++ b/arch/powerpc/include/asm/vdso/processor.h
@@ -4,6 +4,9 @@
=20
 #ifndef __ASSEMBLER__
=20
+#include <asm/cputable.h>
+#include <asm/feature-fixups.h>
+
 /* Macros for adjusting thread priority (hardware multi-threading) */
 #ifdef CONFIG_PPC64
 #define HMT_very_low()		asm volatile("or 31, 31, 31	# very low priority")

