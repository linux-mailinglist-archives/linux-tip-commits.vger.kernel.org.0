Return-Path: <linux-tip-commits+bounces-2710-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DAF9B9EA4
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9B401F23854
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 10:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6757E18A6BD;
	Sat,  2 Nov 2024 10:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qNx2O3P7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2jiqfsel"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECE6185920;
	Sat,  2 Nov 2024 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730542219; cv=none; b=aFtfPsiuUntlxsiF0vmmPOym6ybsu99Icnhi4rrHNKd483MoyOvF0Td3ma4/OKMjx5MmQ4o4SKB2np2hrUqzHy5yAUeXCfIIgJkOlf5WgHk7ftkSBP7zDA5qMo1HORm2mE+sHgarRIX6Fn6WghaBFs3hqBg7V1oOKoYXs44em1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730542219; c=relaxed/simple;
	bh=vPfDel+dR+SXKrXmHb/BVr7glS/wzhhQG1f+7uSsiCM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uWY3jJw1LWfT8gaTcXh7IcWJmNXhVAPlc2delYVoDhFXKY/OII+9We0NgohafiTeFRelKAunaEkMVHku+yKizdNriEUG8BOwnMaaj6J2c3vvxqcAvWEie+IaZh3BAI4dMM4S5s5QseeZW09L7qKC66vQmyCtIuszC5RGM2Jcags=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qNx2O3P7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2jiqfsel; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 10:10:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730542214;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8otV1h8Uhvm7rw31jxCeb4ketiTzkoRbk/e/eJChncs=;
	b=qNx2O3P7Y3WMgx+CqqAot3k6dGu6cLLEkiBbIZmCiwkLUig/DTqWvIcQi78m7eY94sk9hm
	grUoMtPcQ5Aw9Yhc2dEtzNVHEYNb5xTZ2Tbo4n6RqcQKVE0VpngMs38q1+xaFgcqmUVpYO
	gdFFCBuRGl5mAfGCPc+64hYU0nHfm94GMqHJv6Cf+NkMV54sn/fB6/43Nd0WMO+lPebj3b
	sxFGTAx99RWXv0TIojKJJ8N0Zhdmp5A/IAsfBtg0AcctK+/dmsR5KGhEWZe3E6REev3T17
	8lV8CvGiazGc90v4kqiDvIiBkf/5mKRBlb29kNdmKXzjmoou/T3x3ci5D8CE4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730542214;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8otV1h8Uhvm7rw31jxCeb4ketiTzkoRbk/e/eJChncs=;
	b=2jiqfselzCBhsxtcabtBpdRqZmIjCPy2M3y8oHN5TiiP6y1ECrk0JLeKbd8OriagDsGNMD
	/MwmvvklSf+r8yCA==
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
Message-ID: <173054221333.3137.14702727295718131881.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     89f40a2d3c3d91c5796b247d930a6855c3ecb116
Gitweb:        https://git.kernel.org/tip/89f40a2d3c3d91c5796b247d930a6855c3e=
cb116
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:14 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 11:05:14 +01:00

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

