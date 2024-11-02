Return-Path: <linux-tip-commits+bounces-2717-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DC59B9EB9
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E07D1C20D95
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 10:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9F41AB52F;
	Sat,  2 Nov 2024 10:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VcZp9GiJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IDB4Uxgk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5207419DF53;
	Sat,  2 Nov 2024 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730542223; cv=none; b=FokdtEjZes+UevBhDGt+9nKrUWQbViIo6O3IK8A2U0fQEufJ16RW8BlLoaw0a5ova6Jrqsv0qMiX9E3mdrptFooqbmBcMSnV8f4yQe9FGL0RINMKanY6ZChdxFnPjsU0apMUBHRtMaKsU2ClkjQMofu16LeBywskSrbmqgM12CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730542223; c=relaxed/simple;
	bh=wL8TSngGzXA0UIsEcKPHAy7frSxbpZP4v/Md9QssFuo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lNmKUs27wesvRBjT6nKQFRQVNFK+ie9p3u4yLtc3yA3lwHmx4vIiKEmgrYJCpDvTd1Iih3pT1/PXtucd85aqw7Kn490zR0W3gM9ZB7AtMPaQ6Q1A5CynAPZ31di0Jodfk5ClG0qLHN6AIFD6Q5luUwJCXf26EqNPEE0NFV27uK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VcZp9GiJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IDB4Uxgk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 10:10:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730542220;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aMziMWgcTQcZpncEk67bnAPEMbyDvurFqB0FryO+6T8=;
	b=VcZp9GiJTc38rG3hz9V1gvxGyhlTtYSHSZbdibJ652UZyPg+zuwf00fCsTGA9XBR7LMslE
	YkYiW8O4KBO60lyTJq72+uG4c0B4wYNn9bSfyMVv4FxUCCznqwRbiy6e0L8pJBDuPuOCCC
	hhWT7jDspYapplFNbj9qWfr2orzbEPiUXPZL0Jx8rWS38j5ny7BAbtutP+OvZmcOO5sq6p
	h6YxsA1qc+0TMda7SAgAlOziriFoO1jbiFr6/BmgLZmIk+eJMPbuPLd1dd3lgDWJok9EOA
	eho0R7jVHwBhnVdwDEePREseJ00Ki+af28LGPl5/4+Wi8cZP2Q0N2027CphclA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730542220;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aMziMWgcTQcZpncEk67bnAPEMbyDvurFqB0FryO+6T8=;
	b=IDB4Uxgk7jMGFBLwe00oqnDBLqDOvNUKZoUD8HCeKMqgmVdo2Ry9eAvOC/dD7X5KJJCLyk
	EnL+JpwT3pwY4HAQ==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] s390/vdso: Drop LBASE_VDSO
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241010-vdso-generic-base-v1-3-b64f0842d512@linutronix.de>
References: <20241010-vdso-generic-base-v1-3-b64f0842d512@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173054221925.3137.7336999366714580846.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     a5c197dc9bfc8a2fed161cf22e6fd9969af81427
Gitweb:        https://git.kernel.org/tip/a5c197dc9bfc8a2fed161cf22e6fd9969af=
81427
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:05 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 11:05:13 +01:00

s390/vdso: Drop LBASE_VDSO

This constant is always "0", providing no value and making the logic
harder to understand.
Also prepare for a consolidation of the vdso linkerscript logic by
aligning it with other architectures.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Link: https://lore.kernel.org/all/20241010-vdso-generic-base-v1-3-b64f0842d51=
2@linutronix.de

---
 arch/s390/include/asm/vdso.h         | 3 ---
 arch/s390/kernel/vdso32/vdso32.lds.S | 2 +-
 arch/s390/kernel/vdso64/vdso64.lds.S | 2 +-
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/s390/include/asm/vdso.h b/arch/s390/include/asm/vdso.h
index 91061f0..92c73e4 100644
--- a/arch/s390/include/asm/vdso.h
+++ b/arch/s390/include/asm/vdso.h
@@ -12,9 +12,6 @@ int vdso_getcpu_init(void);
=20
 #endif /* __ASSEMBLY__ */
=20
-/* Default link address for the vDSO */
-#define VDSO_LBASE	0
-
 #define __VVAR_PAGES	2
=20
 #define VDSO_VERSION_STRING	LINUX_2.6.29
diff --git a/arch/s390/kernel/vdso32/vdso32.lds.S b/arch/s390/kernel/vdso32/v=
dso32.lds.S
index 65b9513..c916c4f 100644
--- a/arch/s390/kernel/vdso32/vdso32.lds.S
+++ b/arch/s390/kernel/vdso32/vdso32.lds.S
@@ -16,7 +16,7 @@ SECTIONS
 #ifdef CONFIG_TIME_NS
 	PROVIDE(_timens_data =3D _vdso_data + PAGE_SIZE);
 #endif
-	. =3D VDSO_LBASE + SIZEOF_HEADERS;
+	. =3D SIZEOF_HEADERS;
=20
 	.hash		: { *(.hash) }			:text
 	.gnu.hash	: { *(.gnu.hash) }
diff --git a/arch/s390/kernel/vdso64/vdso64.lds.S b/arch/s390/kernel/vdso64/v=
dso64.lds.S
index 753040a..ec42b7d 100644
--- a/arch/s390/kernel/vdso64/vdso64.lds.S
+++ b/arch/s390/kernel/vdso64/vdso64.lds.S
@@ -18,7 +18,7 @@ SECTIONS
 #ifdef CONFIG_TIME_NS
 	PROVIDE(_timens_data =3D _vdso_data + PAGE_SIZE);
 #endif
-	. =3D VDSO_LBASE + SIZEOF_HEADERS;
+	. =3D SIZEOF_HEADERS;
=20
 	.hash		: { *(.hash) }			:text
 	.gnu.hash	: { *(.gnu.hash) }

