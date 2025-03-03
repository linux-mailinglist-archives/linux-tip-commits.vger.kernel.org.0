Return-Path: <linux-tip-commits+bounces-3820-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB937A4CBB7
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 20:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0A4916BBCE
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 19:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B06233D91;
	Mon,  3 Mar 2025 19:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U+GAyW3o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L3EtaN8G"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E523822E405;
	Mon,  3 Mar 2025 19:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741029181; cv=none; b=joTKRJQabBW/9kv5ff2Pkr3zLTadpzg78U1JEN7Z9mSoqAn7yzbsMnLb3wTdxpzPi+2iz5qB2YHXWqFXZBQCqPdqTQfdqxDfoJTznsRF14T1UlhRJsqUQgLewxje1qeAWz4NYo5gKoyx4hTntjYWKpHqor752EEbjJ/DrV65CbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741029181; c=relaxed/simple;
	bh=aV15hQi3XbewAoPuXSppS/5oPVmqu6CxvZ4He8CkseQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZGhdUuMmWKNrsYPxJaAGHjvx5r0zKTx1TZtA6WgdB7ElwXL8HmltzFvGHqs/G4QdP+IR568K+mKxKPL6fR5LKrg8IVXE8C6nudI+qMazCKr3dQXIJQON7O68CzE1Mhe0YMxosPVIJQluMH3okOi5vxNndRFjPfoUvF+giwS0MUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U+GAyW3o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L3EtaN8G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 19:12:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741029178;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VXVGM3FW75JtZwcM8KMMbvyrg15T3UpNxgItniVic1A=;
	b=U+GAyW3oOh9Vtvp/wnSpKIplxP+lAkhJzx33XCMcj1KIejG4ktz0xEftt2nwRPDl4wDafp
	K/BUDGzeXzlRpqKFkt+Id2yfcSNuvqHHpbroqElQ0vr13pGkib9zpsCB4eFr6t49ukYVIp
	bwM9XmE1iPTnDyhK4oTHpYo20jBIexXpGrEvR7jsHekUQRLvRjxbRbUcP/nqJFihcpuMPQ
	qVsNIPAPAFQ1zVQ/8u6nL7F+0HPwkwBD0wwKqqjQXX9XM+Ggev2nO5oc03afvbHf6y89xN
	Rz+MboDKaKaqxxgANpq0uTL4uXSoNTlBrkgd3RFjfTTIetKlvVdnnIgh1pEuLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741029178;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VXVGM3FW75JtZwcM8KMMbvyrg15T3UpNxgItniVic1A=;
	b=L3EtaN8GKqu1g4Y7EYhbFwywxR/3OgykjUc72ql+KVetpPrqyqgOl8BEdSIpX8Fd8Fj8DC
	aViW0ShizE31RDCw==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] selftests: vDSO: parse_vdso: Use UAPI headers
 instead of libc headers
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250226-parse_vdso-nolibc-v2-12-28e14e031ed8@linutronix.de>
References: <20250226-parse_vdso-nolibc-v2-12-28e14e031ed8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174102917783.14745.15601586293194249587.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     c9fbaa879508ea36f5be0b3f1125b8f9f11b4945
Gitweb:        https://git.kernel.org/tip/c9fbaa879508ea36f5be0b3f1125b8f9f11=
b4945
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Wed, 26 Feb 2025 12:44:51 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Mar 2025 20:00:12 +01:00

selftests: vDSO: parse_vdso: Use UAPI headers instead of libc headers

To allow the usage of parse_vdso.c together with a limited libc like
nolibc, use the kernels own elf.h and auxvec.h headers.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Link: https://lore.kernel.org/all/20250226-parse_vdso-nolibc-v2-12-28e14e031e=
d8@linutronix.de
---
 tools/testing/selftests/vDSO/Makefile     | 3 +++
 tools/testing/selftests/vDSO/parse_vdso.c | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/=
vDSO/Makefile
index 1cf14a8..bc8ca18 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -19,6 +19,9 @@ LDLIBS +=3D -lgcc_s
 endif
=20
 include ../lib.mk
+
+CFLAGS +=3D $(TOOLS_INCLUDES)
+
 $(OUTPUT)/vdso_test_gettimeofday: parse_vdso.c vdso_test_gettimeofday.c
 $(OUTPUT)/vdso_test_getcpu: parse_vdso.c vdso_test_getcpu.c
 $(OUTPUT)/vdso_test_abi: parse_vdso.c vdso_test_abi.c
diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selfte=
sts/vDSO/parse_vdso.c
index 3638fe6..200c534 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -19,7 +19,8 @@
 #include <stdint.h>
 #include <string.h>
 #include <limits.h>
-#include <elf.h>
+#include <linux/auxvec.h>
+#include <linux/elf.h>
=20
 #include "parse_vdso.h"
=20

