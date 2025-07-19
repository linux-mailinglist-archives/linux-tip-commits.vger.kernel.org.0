Return-Path: <linux-tip-commits+bounces-6147-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FD8B0B124
	for <lists+linux-tip-commits@lfdr.de>; Sat, 19 Jul 2025 19:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259F417B162
	for <lists+linux-tip-commits@lfdr.de>; Sat, 19 Jul 2025 17:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E07A288C05;
	Sat, 19 Jul 2025 17:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WA77FtOb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PsPqGQPo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EE2287513;
	Sat, 19 Jul 2025 17:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752946822; cv=none; b=T8DkoXk85AAilMD5L3rea0a6qjMjMn5X5bHv/Gto/q00a9nMragY/z2M4FfX2FgZI4C1n+ebTzxNlMhViYe8EGHmhJcwPYDd+2ca+CXuSNEfMfMGaqScqd1ml4qPQmo0LNLaXQu78Xfd8gFVRkMYqEUl0N64Qe9Gawb/sKYVEQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752946822; c=relaxed/simple;
	bh=U0812Cym07syQXHX0WmwnXOXOgIweHG8seaySpFe3qw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=P0/s8qZG4f6Zs6ml5Zjjrz8UiMe7s3cY01g3I4UXJxuOKHYwKjWjx3aQD61yNtOo6tziMd0ADNA2FhuMeJpwOUV0hG4u2ricRIfdXg9YRvj7NTSEN1A53eXQapJyYLFYDjI2dE9enkNrxF6w9p/X2HKcKLdRDA10PCBzlvPJYWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WA77FtOb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PsPqGQPo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 19 Jul 2025 17:40:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752946812;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wwVDuuW9FybqJ2a4RhVpro8xhdDdJelUelDFTNjjOPg=;
	b=WA77FtObciv22fJeYoXRMqchrkUoyDA5+f7Oske8E2Ne2gabgnH2ZT18VrcX7VTUWSfX8Y
	vf+2y2JigI/Ba58JMjfQdlrlPwtu4x2CVA1mNiG34YMYNkRWJ0X8brC803/8qkgMRxkUJn
	/Mb4eASVhSZrmA9891KZuntVP/CAb3u78//ffnwjrsL9blRyektaNItT1pBuqWRU68fMJC
	oKPtr54URQ9XpC8zKCNa0IMb6axvr4bUqOA5Jig2OojqRnZPs3L8SGee1Q0drGMgprHLvE
	V3EEJ9H/6qYMZKxqAFfRuULgVB41Xy9EnBWOq469YKfa3+4NUxyFKj5TXEQtsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752946812;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wwVDuuW9FybqJ2a4RhVpro8xhdDdJelUelDFTNjjOPg=;
	b=PsPqGQPojShQjGU5vG83VNuF2m6w07pA9NAwPl2qNxre5tjJ/EUiag1y6yiQKwvm4ZDCg0
	3C1Z68smmbiPH4DQ==
From: "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/lockdep: Change 'static const' variables
 to enum values
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250409122314.2848028-6-arnd@kernel.org>
References: <20250409122314.2848028-6-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175294681090.1420.17391042185079790860.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     bd27cfb58c2803923702cd80289b35b7b8108859
Gitweb:        https://git.kernel.org/tip/bd27cfb58c2803923702cd80289b35b7b81=
08859
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Wed, 09 Apr 2025 14:22:58 +02:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Mon, 14 Jul 2025 21:57:29 -07:00

locking/lockdep: Change 'static const' variables to enum values

gcc warns about 'static const' variables even in headers when building
with -Wunused-const-variables enabled:

In file included from kernel/locking/lockdep_proc.c:25:
kernel/locking/lockdep_internals.h:69:28: error: 'LOCKF_USED_IN_IRQ_READ' def=
ined but not used [-Werror=3Dunused-const-variable=3D]
   69 | static const unsigned long LOCKF_USED_IN_IRQ_READ =3D
      |                            ^~~~~~~~~~~~~~~~~~~~~~
kernel/locking/lockdep_internals.h:63:28: error: 'LOCKF_ENABLED_IRQ_READ' def=
ined but not used [-Werror=3Dunused-const-variable=3D]
   63 | static const unsigned long LOCKF_ENABLED_IRQ_READ =3D
      |                            ^~~~~~~~~~~~~~~~~~~~~~
kernel/locking/lockdep_internals.h:57:28: error: 'LOCKF_USED_IN_IRQ' defined =
but not used [-Werror=3Dunused-const-variable=3D]
   57 | static const unsigned long LOCKF_USED_IN_IRQ =3D
      |                            ^~~~~~~~~~~~~~~~~
kernel/locking/lockdep_internals.h:51:28: error: 'LOCKF_ENABLED_IRQ' defined =
but not used [-Werror=3Dunused-const-variable=3D]
   51 | static const unsigned long LOCKF_ENABLED_IRQ =3D
      |                            ^~~~~~~~~~~~~~~~~

This one is easy to avoid by changing the generated constant definition
into an equivalent enum.

Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250409122314.2848028-6-arnd@kernel.org
---
 kernel/locking/lockdep_internals.h | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_inte=
rnals.h
index 82156ca..0e5e6ff 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -47,29 +47,31 @@ enum {
 	__LOCKF(USED_READ)
 };
=20
+enum {
 #define LOCKDEP_STATE(__STATE)	LOCKF_ENABLED_##__STATE |
-static const unsigned long LOCKF_ENABLED_IRQ =3D
+	LOCKF_ENABLED_IRQ =3D
 #include "lockdep_states.h"
-	0;
+	0,
 #undef LOCKDEP_STATE
=20
 #define LOCKDEP_STATE(__STATE)	LOCKF_USED_IN_##__STATE |
-static const unsigned long LOCKF_USED_IN_IRQ =3D
+	LOCKF_USED_IN_IRQ =3D
 #include "lockdep_states.h"
-	0;
+	0,
 #undef LOCKDEP_STATE
=20
 #define LOCKDEP_STATE(__STATE)	LOCKF_ENABLED_##__STATE##_READ |
-static const unsigned long LOCKF_ENABLED_IRQ_READ =3D
+	LOCKF_ENABLED_IRQ_READ =3D
 #include "lockdep_states.h"
-	0;
+	0,
 #undef LOCKDEP_STATE
=20
 #define LOCKDEP_STATE(__STATE)	LOCKF_USED_IN_##__STATE##_READ |
-static const unsigned long LOCKF_USED_IN_IRQ_READ =3D
+	LOCKF_USED_IN_IRQ_READ =3D
 #include "lockdep_states.h"
-	0;
+	0,
 #undef LOCKDEP_STATE
+};
=20
 #define LOCKF_ENABLED_IRQ_ALL (LOCKF_ENABLED_IRQ | LOCKF_ENABLED_IRQ_READ)
 #define LOCKF_USED_IN_IRQ_ALL (LOCKF_USED_IN_IRQ | LOCKF_USED_IN_IRQ_READ)

