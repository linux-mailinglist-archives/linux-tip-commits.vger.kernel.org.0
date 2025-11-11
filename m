Return-Path: <linux-tip-commits+bounces-7306-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6EFC4EED2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 17:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CC49634ABA5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 16:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDDE7082A;
	Tue, 11 Nov 2025 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VbCJMYhd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6pHBM9+S"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6018F2E719C;
	Tue, 11 Nov 2025 16:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762877093; cv=none; b=ctQKo1giGNJD5WctbQMKu1FqFMvmiqDuPf8RQ6vLhdKxzniRp4S9chfDygSkuvQ710ZWNt7pqIdP89VLxLxysCUjZ4aJOTjbYqh4UFGCV811oAjqfA68zMrOVmvYOzobFgkF6gMOMLaSsRdm3GZCZ2rcY5805uquNl/st5USoss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762877093; c=relaxed/simple;
	bh=Kh+CbdpJzlLjFO2RQf5VgnmnC0RJatj+pA/eOLJdFhk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rM4fhTzB41U/YxyHep9HI+Ydqp6bD1Xlj0nEU1IJzisO322kYrneuuZAUaswkWL1H9DkYA4YhYPAdIdf4zsrRKPtblMVVrSduahecMvTQbJiboIXxnbbI3GO3/8NKdx4IN07m9DteTn710nEZa9wnFz0urQGSpz33z6AWZR3O7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VbCJMYhd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6pHBM9+S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 16:04:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762877090;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sxsF2MAMuL/4sSmDliSZQfPcjhD4gnZBfS2ezJFc0uI=;
	b=VbCJMYhd9kJWlLU+VDm05Zxy24zLAA3+n35T5ag7fIv5JYWj8IpkengFlj1x7nj4JQ6wjq
	igKWbu0J2uEl9tBVG9doht57YlcAt9Jndu2p1AVGjF6+fRTU1E09EuoGr+u0nLLkDOquof
	Iwz/w0oO3gG0R0b2rH84SbUp4eS4b1WcBrX9xdJTZvNfvzkLEcuq3eD21Gc77HE7dPZv4W
	BH1D4s3LpzH0ebUmZuam2G8QGw0kp8557atGYG2Plj/STPu5oblH47m/2ifLtOkLagnug1
	qYpb4dqRTUJv4KTHA9bhCvtty+AkM7XVa3AmYPXt8w6shiXsAabxENK2XavlKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762877090;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sxsF2MAMuL/4sSmDliSZQfPcjhD4gnZBfS2ezJFc0uI=;
	b=6pHBM9+SSK9fHzHWOSJNuysgAtckg9sUCU0qyPTlIMv98S7S+rAiBZhQGcsTZgkp/qSA78
	k0sIJHu5yf+p99Aw==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/coco/sev: Convert has_cpuflag() to use
 cpu_feature_enabled()
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251031122122.GKaQSpwhLvkinKKbjG@fat_crate.local>
References: <20251031122122.GKaQSpwhLvkinKKbjG@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176287708918.498.7568806227528588666.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     b2c1dd6c6f70a5a519532227358c82d4cfda5b36
Gitweb:        https://git.kernel.org/tip/b2c1dd6c6f70a5a519532227358c82d4cfd=
a5b36
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Thu, 30 Oct 2025 17:59:11 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 11 Nov 2025 16:42:31 +01:00

x86/coco/sev: Convert has_cpuflag() to use cpu_feature_enabled()

Drop one redundant definition, while at it.

There should be no functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20251031122122.GKaQSpwhLvkinKKbjG@fat_crate.lo=
cal
---
 arch/x86/boot/startup/sev-shared.c | 2 +-
 arch/x86/coco/sev/vc-handle.c      | 1 -
 arch/x86/coco/sev/vc-shared.c      | 2 +-
 arch/x86/lib/kaslr.c               | 2 +-
 4 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-s=
hared.c
index 4e22ffd..a0fa8bb 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -12,7 +12,7 @@
 #include <asm/setup_data.h>
=20
 #ifndef __BOOT_COMPRESSED
-#define has_cpuflag(f)			boot_cpu_has(f)
+#define has_cpuflag(f)			cpu_feature_enabled(f)
 #else
 #undef WARN
 #define WARN(condition, format...) (!!(condition))
diff --git a/arch/x86/coco/sev/vc-handle.c b/arch/x86/coco/sev/vc-handle.c
index 7fc136a..f08c750 100644
--- a/arch/x86/coco/sev/vc-handle.c
+++ b/arch/x86/coco/sev/vc-handle.c
@@ -352,7 +352,6 @@ fault:
=20
 #define sev_printk(fmt, ...)		printk(fmt, ##__VA_ARGS__)
 #define error(v)
-#define has_cpuflag(f)			boot_cpu_has(f)
=20
 #include "vc-shared.c"
=20
diff --git a/arch/x86/coco/sev/vc-shared.c b/arch/x86/coco/sev/vc-shared.c
index e2ac95d..58b2f98 100644
--- a/arch/x86/coco/sev/vc-shared.c
+++ b/arch/x86/coco/sev/vc-shared.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
=20
 #ifndef __BOOT_COMPRESSED
-#define has_cpuflag(f)                  boot_cpu_has(f)
+#define has_cpuflag(f)                  cpu_feature_enabled(f)
 #endif
=20
 static enum es_result vc_check_opcode_bytes(struct es_em_ctxt *ctxt,
diff --git a/arch/x86/lib/kaslr.c b/arch/x86/lib/kaslr.c
index b589392..8c7cd11 100644
--- a/arch/x86/lib/kaslr.c
+++ b/arch/x86/lib/kaslr.c
@@ -22,7 +22,7 @@
 #include <asm/setup.h>
=20
 #define debug_putstr(v) early_printk("%s", v)
-#define has_cpuflag(f) boot_cpu_has(f)
+#define has_cpuflag(f) cpu_feature_enabled(f)
 #define get_boot_seed() kaslr_offset()
 #endif
=20

