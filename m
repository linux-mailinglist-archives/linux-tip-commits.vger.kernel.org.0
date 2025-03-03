Return-Path: <linux-tip-commits+bounces-3821-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0924CA4CBB5
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 20:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B423A0579
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 19:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82662356AF;
	Mon,  3 Mar 2025 19:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rdfXtUO1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NTve2/I7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420D7233128;
	Mon,  3 Mar 2025 19:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741029182; cv=none; b=GL675EjDKMr2owWy6YPTdbEyx8s8Tv6JDsmoPW40cDYw9SuZzvpfJS/BRDhY4WzadRoNtIrrPky+5EkkFEoNBd9/JugfI7P20yn1UhLKbAdvb3XJo7XN8LvTMujeFUnbs4RrjYC9JJYA6kEbfsQpmaxAtO50z5KlfY8AkMlvVSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741029182; c=relaxed/simple;
	bh=O84Y7SPA7MHL9EX97D7yvefs3Mc/+HD2I8mB2Kxmi0I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bowQ/ujK6RR2xEkBRZ3zwpJ6YrgZNjPw702vX/JgPA1WZyq6fH1aKP0behlYxSeBUs1J0EwmH/PLKze++GmGOvnH0Gb0NDKuOCdSeG4Q+yvFeylHA2K4t/6rmQL5bx8epCt57IEKr4OcRHl781fWh8ahVxZGcNV7tXNYi/vyfeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rdfXtUO1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NTve2/I7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 19:12:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741029179;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NWbYXOKDuVEtUdH87tn46tCLtLr/rBt2r8C1Nh1De/Q=;
	b=rdfXtUO1Rrn22z1Lcv7yqwIF8QCM1alKnYtIFoRBPDZrEoN115VKmrI6eVDU7zBv+HeNlV
	fkGJ353HpuQ/2LuwEE5yE0TNvJjOipByi7296Yx7C0Hh4HtjmJPbqmOWwrY2xrrwX0TS4e
	/Sh0cgk6skyN6yMYhCIGAIFj1aZCDio1hI/YwoSMaXsKh9tT7LPdVbrikY6Tqr+pTiBWTx
	6CR97+p+DMOWQVxR/IJ1obk4NKrZeMhqMtIwe5znNNIzaAdgFH/jXayeKu0qCQg3ItWw5G
	M7K2jE7kno32NDBtlC6qA/u0PFNuM+cCjIGuOvXv5Kne2RsPeik0P03eNm0ilg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741029179;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NWbYXOKDuVEtUdH87tn46tCLtLr/rBt2r8C1Nh1De/Q=;
	b=NTve2/I7YaN5amhaBXYUJLkxREstGPobze2wLTmozPgDKpjwZkRMJNGwcu33IoGOkUMEEc
	XHQBTWdrzM8+f2CA==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] selftests: vDSO: vdso_standalone_test_x86: Use
 vdso_init_form_sysinfo_ehdr
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250226-parse_vdso-nolibc-v2-10-28e14e031ed8@linutronix.de>
References: <20250226-parse_vdso-nolibc-v2-10-28e14e031ed8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174102917915.14745.12618598584746312348.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     05c204acf5131740f5f4e193c9749b92da4bcb16
Gitweb:        https://git.kernel.org/tip/05c204acf5131740f5f4e193c9749b92da4=
bcb16
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Wed, 26 Feb 2025 12:44:49 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Mar 2025 20:00:12 +01:00

selftests: vDSO: vdso_standalone_test_x86: Use vdso_init_form_sysinfo_ehdr

vdso_standalone_test_x86 is the only user of vdso_init_from_auxv().
Instead of combining the parsing the aux vector with the parsing of the
vDSO, split them apart into getauxval() and the regular
vdso_init_from_sysinfo_ehdr().

The implementation of getauxval() is taken from
tools/include/nolibc/stdlib.h.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Link: https://lore.kernel.org/all/20250226-parse_vdso-nolibc-v2-10-28e14e031e=
d8@linutronix.de
---
 tools/testing/selftests/vDSO/vdso_standalone_test_x86.c | 27 +++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c b/tools/=
testing/selftests/vDSO/vdso_standalone_test_x86.c
index 6449158..500608f 100644
--- a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
+++ b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
@@ -15,6 +15,7 @@
 #include <sys/time.h>
 #include <unistd.h>
 #include <stdint.h>
+#include <linux/auxvec.h>
=20
 #include "parse_vdso.h"
=20
@@ -84,6 +85,30 @@ void to_base10(char *lastdig, time_t n)
 	}
 }
=20
+unsigned long getauxval(const unsigned long *auxv, unsigned long type)
+{
+	unsigned long ret;
+
+	if (!auxv)
+		return 0;
+
+	while (1) {
+		if (!auxv[0] && !auxv[1]) {
+			ret =3D 0;
+			break;
+		}
+
+		if (auxv[0] =3D=3D type) {
+			ret =3D auxv[1];
+			break;
+		}
+
+		auxv +=3D 2;
+	}
+
+	return ret;
+}
+
 void c_main(void **stack)
 {
 	/* Parse the stack */
@@ -96,7 +121,7 @@ void c_main(void **stack)
 	stack++;
=20
 	/* Now we're pointing at auxv.  Initialize the vDSO parser. */
-	vdso_init_from_auxv((void *)stack);
+	vdso_init_from_sysinfo_ehdr(getauxval((unsigned long *)stack, AT_SYSINFO_EH=
DR));
=20
 	/* Find gettimeofday. */
 	typedef long (*gtod_t)(struct timeval *tv, struct timezone *tz);

