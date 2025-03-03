Return-Path: <linux-tip-commits+bounces-3822-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEE0A4CBB9
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 20:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F32D97AA1B8
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 19:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E187B2356B7;
	Mon,  3 Mar 2025 19:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s2FfjODJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TkqgN3/h"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4214B23312D;
	Mon,  3 Mar 2025 19:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741029182; cv=none; b=uuozomyBq82TNO0exkPbFE7RnLbSmcthM2acVfa6ycmHNbOtfvMJZxER/VZ8tIUwiD2yQcTL2CVSSv+8uBC/Ii+zeEypB/JtWCHUrTYpZKAkDKv4aQCYZyaXxblhdtF7xODvL0z0WLBeXpJ1YJ6PktknwV4coVArM21eqQ5MvIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741029182; c=relaxed/simple;
	bh=9waC7ONgc1MPXcicqMZk65GxQCg/cBhaEDQ2vMPf5tg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=alJsK3+U8aozekJcPsWXWfipAHZkSLn2rIal3RDcZPy7Pehp0qGEQzGNQSImJX0V5z+bR1bKIMwbKp1JDG210d0I77FK3w9ju6Rdq9PI6kIjW9xhuoZvuqdQg7xaQsQBZdDWnewj+Uw/3YcBq4QHz5pTKdq7OJ0Ue0PEjEp7O4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s2FfjODJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TkqgN3/h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 19:12:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741029179;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6nxCD+VCc0+poxQscNy8a3DC3G+gkgt8C7FzXcZrg4A=;
	b=s2FfjODJSIPebca0i9zbd4mr45SEnSNiNQCe7/8QPzzSVdh8DAChfT+0ycmeyrP7has6bq
	xEywQbn4KTguFmLN4COwKo0V4oaMdICBTWh124/gGmOwrHK5XPYJ+Sp/x59SzuKhgLOJUc
	ofh4AhA0l/QafaOYsxM8UbY83TTDRdGZBrhcuyemyauc7wRFVvKyzUsFOodKmnn6GYjK89
	4EzTXFPDyxPeZtQbVML1FW3ZIm0ivNnKraLt62qYOHMn/BQF4qja8AL1OEKGv2WWtBQnb7
	RnLavbCjoneSEkLP3zQv4NNK+4WboUu39Hfi/ULJdUo4wpeiM0ZwCkaN2CP69Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741029179;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6nxCD+VCc0+poxQscNy8a3DC3G+gkgt8C7FzXcZrg4A=;
	b=TkqgN3/hpJ+V8P8Xxd/vskueB7SYxRIGim9yKK8MevzKdmpguS063YDJ5NojiEBgNAgZdB
	+0kXzM2zjM1eqsBw==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] selftests: vDSO: parse_vdso: Drop vdso_init_from_auxv()
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250226-parse_vdso-nolibc-v2-11-28e14e031ed8@linutronix.de>
References: <20250226-parse_vdso-nolibc-v2-11-28e14e031ed8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174102917850.14745.14268420233023432223.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     09dcec64707df85f5def668d4724fce832114d91
Gitweb:        https://git.kernel.org/tip/09dcec64707df85f5def668d4724fce8321=
14d91
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Wed, 26 Feb 2025 12:44:50 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Mar 2025 20:00:12 +01:00

selftests: vDSO: parse_vdso: Drop vdso_init_from_auxv()

There are no users left.

This also removes the usage of ElfXX_auxv_t, which is not formally
standardized.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Link: https://lore.kernel.org/all/20250226-parse_vdso-nolibc-v2-11-28e14e031e=
d8@linutronix.de
---
 tools/testing/selftests/vDSO/parse_vdso.c | 14 --------------
 tools/testing/selftests/vDSO/parse_vdso.h |  1 -
 2 files changed, 15 deletions(-)

diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selfte=
sts/vDSO/parse_vdso.c
index 2fe5e98..3638fe6 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -297,17 +297,3 @@ void *vdso_sym(const char *version, const char *name)
=20
 	return 0;
 }
-
-void vdso_init_from_auxv(void *auxv)
-{
-	ELF(auxv_t) *elf_auxv =3D auxv;
-	for (int i =3D 0; elf_auxv[i].a_type !=3D AT_NULL; i++)
-	{
-		if (elf_auxv[i].a_type =3D=3D AT_SYSINFO_EHDR) {
-			vdso_init_from_sysinfo_ehdr(elf_auxv[i].a_un.a_val);
-			return;
-		}
-	}
-
-	vdso_info.valid =3D false;
-}
diff --git a/tools/testing/selftests/vDSO/parse_vdso.h b/tools/testing/selfte=
sts/vDSO/parse_vdso.h
index de04530..09d068e 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.h
+++ b/tools/testing/selftests/vDSO/parse_vdso.h
@@ -26,6 +26,5 @@
  */
 void *vdso_sym(const char *version, const char *name);
 void vdso_init_from_sysinfo_ehdr(uintptr_t base);
-void vdso_init_from_auxv(void *auxv);
=20
 #endif

