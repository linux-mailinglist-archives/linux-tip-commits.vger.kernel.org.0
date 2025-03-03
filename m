Return-Path: <linux-tip-commits+bounces-3827-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3F4A4CBC2
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 20:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8EED188A892
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 19:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BDA23A9BA;
	Mon,  3 Mar 2025 19:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="neNJ3J13";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AwKvZsGP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5683A239086;
	Mon,  3 Mar 2025 19:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741029186; cv=none; b=XMZeUXAL2wfya80/XXUJCyP4LjYSanUuZwV+EUJja3JMPaGtv3f8yEhN2OgT6GQxaHel3ojf9TNQjdv1lo2Ne98YqoB0chDEBAjcl4nUF6TJ2OzG78CyWOQN5QMwsPj/Tx/uE2WvCdg1ISn6giMQ7iHNdtneHNykHIeZ0Jql+SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741029186; c=relaxed/simple;
	bh=qwPopfhOFrFAZBXufrxTXJWNHkyyGQwJS75nIJ2hblk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DePTq44J6GxGjjYcq4twd3E64mdwFIptqwxK6TlQ/3i6TX33StlRnx1xOu5P87Q3ogirdh6XDoX1tcNNoWgfS0aYkDOm6b7iFvTyKF78WDGqNEVcC76ch6toNUZuPuJkdtgoCSJy6q2O9W0RatjF07F7vM9jOpxot/BJPozHJmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=neNJ3J13; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AwKvZsGP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 19:13:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741029184;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0UUB0LR2aX4qL5tpeKJhnSAOCZQIh9kqaMpPMMy13l4=;
	b=neNJ3J13qVbLe7CdIu9JrRdee9FQc6ufNy0ZE6QZZ9j8CKa2E1GB1IgVaA1+z2QxHVZtpJ
	37HdsQdQLnKDwZqn0DYrh1/wUoWSx0JnM9B3v35HB32M/sI0RebyUsPlE/aEQlflM31AXt
	Igq4izpFL//BwSGj8JOpqS8MOWd0ZcwKBwb6frjWGiCSPr4mEUFOGwwMJkCLEpMJyQ92DY
	P77s3sp/Di5YIIXNJlDkVZN77E1x1gNDp+Y3+spPEKX1TetR0gmXDUo1tU/a2zulOxTjVB
	MlUdzjxgRItJ+E73wUuyZVVJ+vdD+uYYdqTZxMgJMqej1wb9U+RK0EOhkSjQWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741029184;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0UUB0LR2aX4qL5tpeKJhnSAOCZQIh9kqaMpPMMy13l4=;
	b=AwKvZsGPyJwSh2DcIjPujMlB0wH7XIfNkT9tScFNYQ0QNmhVBo98pTyYTPfbKZdzSTjtSR
	27I25dUtjzXIB6BQ==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] elf, uapi: Add definitions for VER_FLG_BASE and
 VER_FLG_WEAK
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Kees Cook <kees@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250226-parse_vdso-nolibc-v2-4-28e14e031ed8@linutronix.de>
References: <20250226-parse_vdso-nolibc-v2-4-28e14e031ed8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174102918345.14745.11018462127149858100.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     049d19bb3807e10902d41125c9d511025389718f
Gitweb:        https://git.kernel.org/tip/049d19bb3807e10902d41125c9d51102538=
9718f
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Wed, 26 Feb 2025 12:44:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Mar 2025 20:00:11 +01:00

elf, uapi: Add definitions for VER_FLG_BASE and VER_FLG_WEAK

The definitions are used by tools/testing/selftests/vDSO/parse_vdso.c.

To be able to build the vDSO selftests without a libc dependency,
add the definitions to the kernels own UAPI headers.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Link: https://docs.oracle.com/cd/E19683-01/816-1386/chapter6-80869/index.html
Link: https://lore.kernel.org/all/20250226-parse_vdso-nolibc-v2-4-28e14e031ed=
8@linutronix.de
---
 include/uapi/linux/elf.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index c5383cc..d040f12 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -136,6 +136,9 @@ typedef __s64	Elf64_Sxword;
 #define STT_COMMON  5
 #define STT_TLS     6
=20
+#define VER_FLG_BASE 0x1
+#define VER_FLG_WEAK 0x2
+
 #define ELF_ST_BIND(x)		((x) >> 4)
 #define ELF_ST_TYPE(x)		((x) & 0xf)
 #define ELF32_ST_BIND(x)	ELF_ST_BIND(x)

