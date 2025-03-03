Return-Path: <linux-tip-commits+bounces-3829-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 274B7A4CBC3
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 20:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 953123A00E8
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 19:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC31723BFA3;
	Mon,  3 Mar 2025 19:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e5bgE6VF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vcl4z/dd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA3123312D;
	Mon,  3 Mar 2025 19:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741029187; cv=none; b=ddK62+Se3FeTxRRR1G5nSuc/OE95r238WeMwmTUkQ8mV1YYtaLDy2mShFa0ejjUm7EAjorQx1DbbjjxuM/CBAX7JcK+nT/J0iizfPjqTTRdzZul2fv8o9TjCfcXCWB4Zuv0aM+6iMNArE6d+fq8e/F6FYX+MgsPWppgZSDu+ZCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741029187; c=relaxed/simple;
	bh=NXu1J97l/SGDiclKnQ3s4pIC/BFS9dp7PCFw/qduF28=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=r4WLywRxBsHXRPVUXBLrteJEe9whmrm0eWGylkPAFg7+RTtuMBZuq5DGhxKmQJEvONLhHOWxur/fyzOJiR3NXM/jx15wfLz+KYJ7RG9uaJLwIdX31tsVF4ODdehQRkgQLN1gxSGQKP+FNr0X8/0bKLPM3vPujnMaFZiqu1umVEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e5bgE6VF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vcl4z/dd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 19:13:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741029183;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UJWgr19P8ZgbsEEK+4ndWHkw7uLEzV1S6K5BkYPnc0M=;
	b=e5bgE6VFBlyDdtWUvNrSW7QhLIlPn4n/xcDNqDhWBX0lesVzyQDZfjf7Wt2FPNbHH/+isa
	aQ/vjzGfdEWKptylc1mLEUQEcIfc94TTRtEGqvoGYtN+w5KmkDIZlBp0FpwOecg6ImznBI
	4V+sHTKRt3Tt4gbtq/iyLPtM0Z6gE7A7Qhpi0rpAT65OIspdHO//v3dTqOcOjCpr7HQVKf
	692unaJUBk6Ci6tznqC7wWOVMiQzJgzaYBPe7aoUXkR6e+1u16tXy/o6MmA5Y6wDl8p+l9
	iE+KUwt6/ulA6C95sB1441WIDNXpKAmgOgBOWfu9RnF/TuEXHRct5qiR6v1q0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741029183;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UJWgr19P8ZgbsEEK+4ndWHkw7uLEzV1S6K5BkYPnc0M=;
	b=Vcl4z/ddTWvb5sD3GNxK0Zos5izQrA0v8qsE8XmNuoCnxLxbihkYRhFVvjx9clVEL66W8X
	JTrbw4lOIyKJ+xDQ==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] elf, uapi: Add type ElfXX_Versym
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Kees Cook <kees@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250226-parse_vdso-nolibc-v2-5-28e14e031ed8@linutronix.de>
References: <20250226-parse_vdso-nolibc-v2-5-28e14e031ed8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174102918270.14745.96404151206587816.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     2c86f604f85def1be0b7889c18e055ed63591018
Gitweb:        https://git.kernel.org/tip/2c86f604f85def1be0b7889c18e055ed635=
91018
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Wed, 26 Feb 2025 12:44:44 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Mar 2025 20:00:11 +01:00

elf, uapi: Add type ElfXX_Versym

The type is used by tools/testing/selftests/vDSO/parse_vdso.c.

To be able to build the vDSO selftests without a libc dependency,
add the type to the kernels own UAPI headers. As documented by elf(5).

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Link: https://lore.kernel.org/all/20250226-parse_vdso-nolibc-v2-5-28e14e031ed=
8@linutronix.de
---
 include/uapi/linux/elf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index d040f12..8846fe0 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -11,6 +11,7 @@ typedef __u16	Elf32_Half;
 typedef __u32	Elf32_Off;
 typedef __s32	Elf32_Sword;
 typedef __u32	Elf32_Word;
+typedef __u16	Elf32_Versym;
=20
 /* 64-bit ELF base types. */
 typedef __u64	Elf64_Addr;
@@ -21,6 +22,7 @@ typedef __s32	Elf64_Sword;
 typedef __u32	Elf64_Word;
 typedef __u64	Elf64_Xword;
 typedef __s64	Elf64_Sxword;
+typedef __u16	Elf64_Versym;
=20
 /* These constants are for the segment types stored in the image headers */
 #define PT_NULL    0

