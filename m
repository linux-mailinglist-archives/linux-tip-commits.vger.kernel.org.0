Return-Path: <linux-tip-commits+bounces-6449-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D88F7B43739
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 11:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCF6D18929DC
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 09:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003072FB631;
	Thu,  4 Sep 2025 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v8dVD7Y5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TkFXlWnW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC3B2FA0F5;
	Thu,  4 Sep 2025 09:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756978345; cv=none; b=L46TMuFhrB1/ltPga04nqGUpP4dqDwOW40lvwhqhJt/HcnDXovyjZv2etRCCrjxZcUgMcwXVcqrRxtzcogOgf4V5YfhDGP+p2fbdWU1l805BgpOIc1V68HBHmzwOjBMYjLDWxOfEMRmMP1dcwpmq+DO/D+mbOws26rGNi6g+Vt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756978345; c=relaxed/simple;
	bh=Oah0AGutumwTyR9hBE8l7sxNHRrTCaQuoDqsSolChgQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fWGEwklgv6T/ovqtiUdPZuuSkjnstG9M34eEAi4xjpDDyzczW6ISvstIXglwk5wWugXgN4f2vrmrOuZP+17owLeQN59NxsMshAS//7geJDkttedpIHENqPYniES/j6dvR6vK9dg9x87tzPwBcTp4Y11sp5QVX0EX22lk25LdegA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v8dVD7Y5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TkFXlWnW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 09:32:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756978343;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sY0LAylfXfFf8LKptu0/YkhCdW6W11m19cQBy+FxCso=;
	b=v8dVD7Y5OY0APegB6IvzrkvHO+NCIZLok6eMmWCTA0+e6LX5Z0xw32yBBHo7CJRFYYxRmG
	A97LiYKa5MQTX09ZQzIQLlb4AD8nrtuJUPR2NxArpfPoyj2tEVtbaWXd1LiSKIj2w/yeHg
	8crmRt7eax5lz+GwjD7BJPAaUoFbKfAalxAKhjzt/kXCxSGPWrZh8eUMd/dYQZUHnZXM23
	A1S6wISMZlDgS0iPpyO1R0dbYD7qh5k+gRCO2triQtjrF6jPYnazEFHaluqB6eCOgjvLji
	0gOg7pTvhwvTtXEFxBDHPbXwAyFHDLmvgDjvKn3ObJWrcKP2LhaOLfZsMdHgzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756978343;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sY0LAylfXfFf8LKptu0/YkhCdW6W11m19cQBy+FxCso=;
	b=TkFXlWnWsOYi+Ydm+9TKdLcSmvDr227saxUXnWtl+k4TtRAGlNJmEuzYACuWltn4TDbhFZ
	JYH63khuYrD0+TBw==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso/gettimeofday: Remove !CONFIG_TIME_NS stubs
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250826-vdso-cleanups-v1-4-d9b65750e49f@linutronix.de>
References: <20250826-vdso-cleanups-v1-4-d9b65750e49f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175697834179.1920.6880568111976258693.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     f145d6bf8d590954672a4d0581c92e1799e9c8da
Gitweb:        https://git.kernel.org/tip/f145d6bf8d590954672a4d0581c92e1799e=
9c8da
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 26 Aug 2025 08:17:07 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 04 Sep 2025 11:23:49 +02:00

vdso/gettimeofday: Remove !CONFIG_TIME_NS stubs

All calls of these functions are already gated behind CONFIG_TIME_NS. The
compiler will already optimize them away if time namespaces are disabled.

Drop the unnecessary stubs.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250826-vdso-cleanups-v1-4-d9b65750e49f@li=
nutronix.de

---
 lib/vdso/gettimeofday.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 02ea19f..1e2a40b 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -108,8 +108,6 @@ bool vdso_get_timestamp(const struct vdso_time_data *vd, =
const struct vdso_clock
 	return true;
 }
=20
-#ifdef CONFIG_TIME_NS
-
 #ifdef CONFIG_GENERIC_VDSO_DATA_STORE
 static __always_inline
 const struct vdso_time_data *__arch_get_vdso_u_timens_data(const struct vdso=
_time_data *vd)
@@ -149,20 +147,6 @@ bool do_hres_timens(const struct vdso_time_data *vdns, c=
onst struct vdso_clock *
=20
 	return true;
 }
-#else
-static __always_inline
-const struct vdso_time_data *__arch_get_vdso_u_timens_data(const struct vdso=
_time_data *vd)
-{
-	return NULL;
-}
-
-static __always_inline
-bool do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_clo=
ck *vcns,
-		    clockid_t clk, struct __kernel_timespec *ts)
-{
-	return false;
-}
-#endif
=20
 static __always_inline
 bool do_hres(const struct vdso_time_data *vd, const struct vdso_clock *vc,
@@ -204,7 +188,6 @@ bool do_hres(const struct vdso_time_data *vd, const struc=
t vdso_clock *vc,
 	return true;
 }
=20
-#ifdef CONFIG_TIME_NS
 static __always_inline
 bool do_coarse_timens(const struct vdso_time_data *vdns, const struct vdso_c=
lock *vcns,
 		      clockid_t clk, struct __kernel_timespec *ts)
@@ -233,14 +216,6 @@ bool do_coarse_timens(const struct vdso_time_data *vdns,=
 const struct vdso_clock
=20
 	return true;
 }
-#else
-static __always_inline
-bool do_coarse_timens(const struct vdso_time_data *vdns, const struct vdso_c=
lock *vcns,
-		      clockid_t clk, struct __kernel_timespec *ts)
-{
-	return false;
-}
-#endif
=20
 static __always_inline
 bool do_coarse(const struct vdso_time_data *vd, const struct vdso_clock *vc,

