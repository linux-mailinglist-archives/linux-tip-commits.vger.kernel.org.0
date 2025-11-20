Return-Path: <linux-tip-commits+bounces-7430-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B49DEC760FA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 20:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 974C24E1374
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 19:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5662F60A4;
	Thu, 20 Nov 2025 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XXB+1PTa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="haVCzI8+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA001F4CB3;
	Thu, 20 Nov 2025 19:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763666576; cv=none; b=kebCuBKYQZv2I5uYw6YW6KAEimUNBb3r3XcCIx08cpTs6ZklJTv+WgGcvrNb0g0I9QoVbjC7ntXiQ1Cu8lg+3T0sm8uilWEcUs4f+aSuDQ8ztas6xOnZLQjUaKD3D7gw5fB61q9T9K3y3JbqyOzTBt80Qxu+p+OJ7auE8hePSgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763666576; c=relaxed/simple;
	bh=5nYsFCJU+fkYKEoh46grs9ian0d3y95K9aL3TqF+yn0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VAZkqlr1xlhiitsEddgfR7tktUrkYYRSNkQw2M46bbpvrxUDAH3yFMg5I9cKfUxUX4Jsh9WrqTDgGdfJvaBXDk7HaOzAalrJ+A2yGxt+JiZr8IwEx/TZd3usfxzw7wtpslOhp7fFk89k4OIyLXKLqepGcv4GhM5TIvss+b8m6g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XXB+1PTa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=haVCzI8+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Nov 2025 19:22:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763666573;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oo+HTl7vzNw9EQVVXPt2pw9axLVVoNRluOcYJvV3we8=;
	b=XXB+1PTacb4FclWLvGt3AUzfZgZgtHms1ZQnt0fsRKlCqgiNC+U51dvBDQtLRP57gXL5ok
	evZhCrTtbKwG6d/GYNoiXq6ja/PM8n2H8C18Kk1+EKVvA0UZAXDc41tQY6xKUhqXh3daip
	W+8XUdas8/0ywXscXn9GTRZg/xSCv2zg9wBjDIgaIvR/OQJtd/1eiNNnZtvxbJ4OXMV06X
	IZMngdDUkWdr2IWfHcgvp+Vk8FAsHWjXvO+rSP1EoOgHicwZht6JAR7HD2gI2c2w47PIDB
	yT1dSx7ptXrRPajLkSYCTsaIExWsYGQyXFx423XpHIZWSrDKDsI9cjDeGmXilw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763666573;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oo+HTl7vzNw9EQVVXPt2pw9axLVVoNRluOcYJvV3we8=;
	b=haVCzI8+sxSHL1x1Mh2EcMKk+4mBfv3a8RHZAE9a10Y+89yF5JELY4W2/1LKKgrm4JWxMA
	WzQUlQbb7mNHarBg==
From: "tip-bot2 for Yury Norov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] cpumask: Add initialiser to use cleanup helpers
Cc: Yury Norov <yury.norov@gmail.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251120145653.296659-7-gmonaco@redhat.com>
References: <20251120145653.296659-7-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176366657213.498.6191918998138782012.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b56651007fc018effe695a68d48caa6970b23094
Gitweb:        https://git.kernel.org/tip/b56651007fc018effe695a68d48caa6970b=
23094
Author:        Yury Norov <yury.norov@gmail.com>
AuthorDate:    Thu, 20 Nov 2025 15:56:52 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 20 Nov 2025 20:17:32 +01:00

cpumask: Add initialiser to use cleanup helpers

Now we can simplify a code that allocates cpumasks for local needs.

Automatic variables have to be initialized at declaration, or at least
before any possibility for the logic to return, so that compiler
wouldn't try to call an associate destructor function on a random stack
number.

Because cpumask_var_t, depending on the CPUMASK_OFFSTACK config, is
either a pointer or an array, we have to have a macro for initialization.

So define a CPUMASK_VAR_NULL macro, which allows to init struct cpumask
pointer with NULL when CPUMASK_OFFSTACK is enabled, and effectively a
no-op when CPUMASK_OFFSTACK is disabled (initialisation optimised out
with -O2).

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://patch.msgid.link/20251120145653.296659-7-gmonaco@redhat.com
---
 include/linux/cpumask.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index ff8f41a..68be522 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -1005,6 +1005,7 @@ static __always_inline unsigned int cpumask_size(void)
=20
 #define this_cpu_cpumask_var_ptr(x)	this_cpu_read(x)
 #define __cpumask_var_read_mostly	__read_mostly
+#define CPUMASK_VAR_NULL		NULL
=20
 bool alloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags, int node);
=20
@@ -1051,6 +1052,7 @@ static __always_inline bool cpumask_available(cpumask_v=
ar_t mask)
=20
 #define this_cpu_cpumask_var_ptr(x) this_cpu_ptr(x)
 #define __cpumask_var_read_mostly
+#define CPUMASK_VAR_NULL {}
=20
 static __always_inline bool alloc_cpumask_var(cpumask_var_t *mask, gfp_t fla=
gs)
 {

