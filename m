Return-Path: <linux-tip-commits+bounces-7163-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 831AFC28779
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF59C4F5CCE
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5794F3148C6;
	Sat,  1 Nov 2025 19:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="shJMYQex";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eAmXkFHe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ED7311976;
	Sat,  1 Nov 2025 19:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026497; cv=none; b=P+zXAX/tBrqnTeE14l/kb41tk3IVgAKK8LiZYzxUy7XcMSTuqZaoBrzP6Ejt/lCoJhPbTW8YCXDYafyOE5jCOGheZghsMA40kgWGTi+RLvEidcfTII7+pEa/MzJkRKdPEhfg+g9HIGzKJsmTePaSYpvAKuMfYnKMojGUj9DCB/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026497; c=relaxed/simple;
	bh=cn4U4N74oOAe7iqJRXQoZq4uzOlX8RzUldEvNnM/Mxk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dsmOuR0HDj/lUpX3r+4UHBZeNVS8eupIexDmP09IQsm7aXvRKex36pW1TPW9YfYuMc1shNMmuXuuF++G29xb2UCHOd5mP4zoWAAPph4CYUEOJOVX/y0Gku3z6IRHlMxy/wwlFVd74LElMcsms1PQYzUT7jaNwsnffx+gzvLwbWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=shJMYQex; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eAmXkFHe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:48:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026494;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EOGe+TfagGYxv/3RzZjcuB0zQFIC/4psEBX26FfPzsI=;
	b=shJMYQexGingq2/t0GC+GiiRNMfZz5E8+03E54sb5t6sOdDdKyTi3f09aA/Z7iYxtk1ARB
	dbbAzp53R+cJ7wFDsWaGKN6xXZg/RmRZdsR8hJg4RkSSXLPF0LVXKGmFQVeLI/dHm06tVh
	KR8Yx9EoziS/ST1uDvM3ahzwVI9fHY6NuwxN7mDl4Ov2ptD6H6SLx5F8x/TAkvZG8/if6q
	qglvwyqCjMYXFRei7aNmPVO3FmH80xvExDsECfqb7OPfX2fuYEAGee7e3zsh5bj3juIrnF
	yN/roLnCKW0RYbiVJrUznNZ9s8UFlkpx4WqLXQmWKa8LFhb7RBjHWvMXoeEg+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026494;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EOGe+TfagGYxv/3RzZjcuB0zQFIC/4psEBX26FfPzsI=;
	b=eAmXkFHe3FnqExlqL7p1jXXVHndG5Flr04NrYisvOgHXFoRhsa8dlt2oH3GSLLm2SM/Fm7
	2DD36bXTfnCX3oAg==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] arm64: vDSO: gettimeofday: Explicitly include
 vdso/clocksource.h
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Andreas Larsson <andreas@gaisler.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251014-vdso-sparc64-generic-2-v4-3-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-3-e0607bf49dea@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202649296.2601451.13056848117084663330.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     fa41cc6b68bb4966496b371b82a86b52cfbf8771
Gitweb:        https://git.kernel.org/tip/fa41cc6b68bb4966496b371b82a86b52cfb=
f8771
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 14 Oct 2025 08:48:49 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:44:02 +01:00

arm64: vDSO: gettimeofday: Explicitly include vdso/clocksource.h

The reference to VDSO_CLOCKMODE_NONE requires vdso/clocksource.h. Currently
this header is included transitively, but that transitive inclusion is
about to go away.

Explicitly include the header.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Link: https://patch.msgid.link/20251014-vdso-sparc64-generic-2-v4-3-e0607bf49=
dea@linutronix.de
---
 arch/arm64/include/asm/vdso/gettimeofday.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/vdso/gettimeofday.h b/arch/arm64/include/=
asm/vdso/gettimeofday.h
index c59e841..909780b 100644
--- a/arch/arm64/include/asm/vdso/gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/gettimeofday.h
@@ -9,6 +9,8 @@
=20
 #ifndef __ASSEMBLY__
=20
+#include <vdso/clocksource.h>
+
 #include <asm/alternative.h>
 #include <asm/arch_timer.h>
 #include <asm/barrier.h>

