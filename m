Return-Path: <linux-tip-commits+bounces-7161-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C870C28788
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3BA18952C6
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09751303A1E;
	Sat,  1 Nov 2025 19:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N2udtzUA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qEJeiejc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638C93128A5;
	Sat,  1 Nov 2025 19:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026494; cv=none; b=mujETatRbvxY/g6znAjDwQ1sKghUnZcOVg65t4XsZCYaVTzXGwpKJEWOd5Yd2fyb0eKRv4iJoixFP+1WS4+QvYBFnmvNqi3E9e4HzdBxZC7dJ2zIn5DYa4GADFS+kLkDOMaYELpc62usl5DPAHbD6lIEW3ZrbsB2pdIKnQBnkPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026494; c=relaxed/simple;
	bh=nxS7T0tydLDhdnt1mMAADC+ndZkQpQKtHzG1JKL8BoY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HRYzCjJpbb39o2YWSjQqIyVcqCoWeMFvLWvzLr8ep4+I8wniu/uB9/frPpOq9HHDqKO4xMen37UZpZLf707TOWE7mluJbjo/EYWigi8ZNYqNo/0yPJ2l3GANbQvrmffB7fnNgfbVbe+c63HsAbpg7CG/jJZjpkTwrF5SQjAB2OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N2udtzUA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qEJeiejc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:48:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026491;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mJOhjOPJ3eT28CRvLAOfS4XVXrjYLtXch9mOWg5pAtE=;
	b=N2udtzUAfN7Hg1CTSgrn98YRUuKZxWQEPOLjdNP2cuJS5fmlBU+E8CdclJPdVWzlZzIWpo
	Py4bBW1Up5UWjILIXjvbe82zb78RkKFEUi0kx0lsEfZ3ap/yfxpPknoR+aMnhl334nuT+0
	5oBRwPT09K+LloXXf5Gsk3LLFKrB2T63+Z1TXCbcA3dQEJGknCdxdyZF22ruGMkJ/ATbh9
	v+6K/T0dU944/rLC0P2PsGpUxrdM6AxgiR/8EVlzUjUJhEjVK6PdEy3KGrcOJWO6o+m5mY
	l8mXxHNcdW1Kqz+wzrwaZqbWAr4YZh0EnTit55mHmrma7BvCnhGGSYbEtCEVoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026491;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mJOhjOPJ3eT28CRvLAOfS4XVXrjYLtXch9mOWg5pAtE=;
	b=qEJeiejcxPFswPdFJMrrXU+k7bSGZoikroOMuyUAOfPHwZeMkJzUNI0H6XSJsM3JMeFrqK
	CIItoqYId9pZQIDA==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] ARM: vdso: gettimeofday: Add explicit includes
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Andreas Larsson <andreas@gaisler.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251014-vdso-sparc64-generic-2-v4-5-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-5-e0607bf49dea@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202649045.2601451.2413530102114307917.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     0657c176ec7cfa49598d55364a0c8b8914769b83
Gitweb:        https://git.kernel.org/tip/0657c176ec7cfa49598d55364a0c8b89147=
69b83
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 14 Oct 2025 08:48:51 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:44:02 +01:00

ARM: vdso: gettimeofday: Add explicit includes

The reference to VDSO_CLOCKMODE_NONE requires vdso/clocksource.h and
'struct old_timespec32' requires vdso/time32.h. Currently these headers
are included transitively, but those transitive inclusions are about to go
away.

Explicitly include the headers.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Link: https://patch.msgid.link/20251014-vdso-sparc64-generic-2-v4-5-e0607bf49=
dea@linutronix.de
---
 arch/arm/include/asm/vdso/gettimeofday.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/vdso/gettimeofday.h b/arch/arm/include/asm/=
vdso/gettimeofday.h
index 1e9f816..26da5d8 100644
--- a/arch/arm/include/asm/vdso/gettimeofday.h
+++ b/arch/arm/include/asm/vdso/gettimeofday.h
@@ -11,6 +11,8 @@
 #include <asm/errno.h>
 #include <asm/unistd.h>
 #include <asm/vdso/cp15.h>
+#include <vdso/clocksource.h>
+#include <vdso/time32.h>
 #include <uapi/linux/time.h>
=20
 #define VDSO_HAS_CLOCK_GETRES		1

