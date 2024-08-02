Return-Path: <linux-tip-commits+bounces-1911-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E97F9458C1
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 09:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E313B283932
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 07:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD361C0DFB;
	Fri,  2 Aug 2024 07:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B5BCB9EA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TWrXYlnD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71E31BF33C;
	Fri,  2 Aug 2024 07:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722583731; cv=none; b=bpdyfqvhqIyIbyaeb9axsnaH9xIXG5hF/Al3ncUzxL+cEzLcuVFKRtClm8FRP+07I7Wk5HNO4fJRqqYGsPB1TkKLQuuGbRIhUh4ROvQswCbDBOj4QZzvk7aahDDs11yvQtUUMlaNCQtoF17J6LyxPwgLpuxSBG3LA0kuEhi/qyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722583731; c=relaxed/simple;
	bh=F47F/+0quv+1KnCM4DN2qnxDsjNvXcMFd6E2tWl+SEg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=g/hkronbQSe7G0swXsVug7U2Gd2FNu9QC9IrgV5+k6UsYkbRpamWThh19cYTjlfd/N9LCfW6p4QCGemaip659uTnU2W0TdzSNviCihS+OGwPIims+k2Fio9N+y7I9tTZB49DCx+dz5ET6fOU30dQzU8V4mqANNSCmfg/7N+PVEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B5BCB9EA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TWrXYlnD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 Aug 2024 07:28:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722583725;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jvuQ127CaM131VwDwOCkeLPVGLA78H9TIiDA8ShQtFs=;
	b=B5BCB9EA1enbXTlbdFws3L4OhyAA2IoRKodCr7Ujlr9YS5DHlZAgDBZ4GcY222QdDq2GzF
	f7YeGZOq/HpMPmVHw/pWsKwRWz6kfFqQ0LVnmwVpHt0vrh0e/UcMzGTf3WTT/Jp/QiaI29
	wwNMuKE93rn8LEidjwHXaE4/ypTqVUz54dEP7VT9O0hOupANkdjhfSvoRxaFs4BqE/e7a0
	GeQmnp0ufPx1tAvOl58jyG3viW9K9sFW9fAWyqZZLX4HWUduWkMGyarJZ3nA1k1Ik7X7L4
	XoUZIb9PzOmaZQQl51yMlpcRDlSzSWrZv3UU2t5R1iR/GhN0ZLWjR+0tPO55rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722583725;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jvuQ127CaM131VwDwOCkeLPVGLA78H9TIiDA8ShQtFs=;
	b=TWrXYlnD9EBn/SQWWvq03VZVEpqCGPqmrqhlxnJvHXFu1j6ZTcUY9ghJlqkdQq8mWV3m8a
	cSPsMDPGDGdVf7DA==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/misc] tools/x86/kcpuid: Protect against faulty "max subleaf" values
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240718134755.378115-5-darwi@linutronix.de>
References: <20240718134755.378115-5-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172258372549.2215.10212071506505066961.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     cf96ab1a966b87b09fdd9e8cc8357d2d00776a3a
Gitweb:        https://git.kernel.org/tip/cf96ab1a966b87b09fdd9e8cc8357d2d007=
76a3a
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Thu, 18 Jul 2024 15:47:44 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Aug 2024 09:17:19 +02:00

tools/x86/kcpuid: Protect against faulty "max subleaf" values

Protect against the kcpuid code parsing faulty max subleaf numbers
through a min() expression.  Thus, ensuring that max_subleaf will always
be =E2=89=A4 MAX_SUBLEAF_NUM.

Use "u32" for the subleaf numbers since kcpuid is compiled with -Wextra,
which includes signed/unsigned comparisons warnings.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240718134755.378115-5-darwi@linutronix.de

---
 tools/arch/x86/kcpuid/kcpuid.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index a87cddc..581d28c 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -7,7 +7,8 @@
 #include <string.h>
 #include <getopt.h>
=20
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+#define ARRAY_SIZE(x)	(sizeof(x) / sizeof((x)[0]))
+#define min(a, b)	(((a) < (b)) ? (a) : (b))
=20
 typedef unsigned int u32;
 typedef unsigned long long u64;
@@ -206,12 +207,9 @@ static void raw_dump_range(struct cpuid_range *range)
 #define MAX_SUBLEAF_NUM		64
 struct cpuid_range *setup_cpuid_range(u32 input_eax)
 {
-	u32 max_func, idx_func;
-	int subleaf;
+	u32 max_func, idx_func, subleaf, max_subleaf;
+	u32 eax, ebx, ecx, edx, f =3D input_eax;
 	struct cpuid_range *range;
-	u32 eax, ebx, ecx, edx;
-	u32 f =3D input_eax;
-	int max_subleaf;
 	bool allzero;
=20
 	eax =3D input_eax;
@@ -256,7 +254,7 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 		 * others have to be tried (0xf)
 		 */
 		if (f =3D=3D 0x7 || f =3D=3D 0x14 || f =3D=3D 0x17 || f =3D=3D 0x18)
-			max_subleaf =3D (eax & 0xff) + 1;
+			max_subleaf =3D min((eax & 0xff) + 1, max_subleaf);
=20
 		if (f =3D=3D 0xb)
 			max_subleaf =3D 2;

