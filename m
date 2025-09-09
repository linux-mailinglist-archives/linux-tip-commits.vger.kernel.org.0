Return-Path: <linux-tip-commits+bounces-6518-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE227B4A674
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 11:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B9893AFB11
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 09:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6FB283FDF;
	Tue,  9 Sep 2025 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LL6D+0BG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rqg1IBtI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4849C27511E;
	Tue,  9 Sep 2025 09:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408564; cv=none; b=uIPPqjpLdyfezMz5IKFFGFgTVxxXKYbriw128/bChcWY3dwlbUDlSJVsrGmCMrKc9NecfUprILsBVrsAMRVeG5kqxeSt7XauCMib2sMCmsSWi1OMOVwDoOCQsfJWDfiA4dX7jeSiXPT1sgZpypIin1gwCF+iAMZ7aiXBCNlH0OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408564; c=relaxed/simple;
	bh=VDMfF8O3z3I/AwJf4tEqRe8hiIkl5rH3N2nW21qsRxE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PyfT3LLCUbA0LlEX2hGryjnN0phLr3Zm9LIJp5Jd4TrOGsWvmRlfQXrscryrG4JMy27e5HVdIMGs2+In/aGFgNI8llMIAAQ18QiC73VBQkdXS/0qxuF7gT8+z+wxIFDW4mMsLHDkLyqufNmgvdQSSTnV90kbuJymUkzTyQqzwIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LL6D+0BG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rqg1IBtI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 09:02:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757408561;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6EEiMSSWv2MIamd154+OPn++CuastFjl/4J6dYC3Xi0=;
	b=LL6D+0BGUmmC/sBcDTHYaxZZZ3a3lEea8CCoGE+9Khl4oSaRLQjChEywgbd+ugIwS+si3x
	of41Sp/RdWlU7D5q/Y5LUZzEBuHUAEwSXUcUhQ8gMbzB2/qORV3vNtuh3XMlMIDsIVzpol
	7Dx3ZTb9b+18r+lD3KcMNxm6KDQqWJnXG86xwA9LKoxhPWYkBk73y2NiII5QgilPk+C8j4
	Cc1qQVBaLLe3hSMkDATcq6onSBT4qlY0TVgCwTI08+aNdVK/+4S9zBWxSPR8erKNS2kFV7
	t3ODqZYdIkxlwNrks1ZuEzApHH07cIXZZDoD+NpfibGk1xhHZf5lKSWvPgqoPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757408561;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6EEiMSSWv2MIamd154+OPn++CuastFjl/4J6dYC3Xi0=;
	b=rqg1IBtIDIe5zULLQuAA7/KCY86SX/OkIw7SB9jc+BvqdsVNtVz0uKdCFj4/Kr0njqOTUP
	djqs1/jpLlvLjIDw==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] selftests: vDSO: vdso_test_abi: Correctly skip
 whole test with missing vDSO
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250812-vdso-tests-fixes-v2-2-90f499dd35f8@linutronix.de>
References: <20250812-vdso-tests-fixes-v2-2-90f499dd35f8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175740856023.1920.7634485400538853948.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     4b59a9f7628fd82b24f2148f62cf327a84d26555
Gitweb:        https://git.kernel.org/tip/4b59a9f7628fd82b24f2148f62cf327a84d=
26555
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 12 Aug 2025 07:39:03 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Sep 2025 10:57:38 +02:00

selftests: vDSO: vdso_test_abi: Correctly skip whole test with missing vDSO

If AT_SYSINFO_EHDR is missing the whole test needs to be skipped.
Currently this results in the following output:

	TAP version 13
	1..16
	# AT_SYSINFO_EHDR is not present!

This output is incorrect, as "1..16" still requires the subtest lines to
be printed, which isn't done however.

Switch to the correct skipping functions, so the output now correctly
indicates that no subtests are being run:

	TAP version 13
	1..0 # SKIP AT_SYSINFO_EHDR is not present!

Fixes: 693f5ca08ca0 ("kselftest: Extend vDSO selftest")
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250812-vdso-tests-fixes-v2-2-90f499dd35f8=
@linutronix.de

---
 tools/testing/selftests/vDSO/vdso_test_abi.c |  9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/sel=
ftests/vDSO/vdso_test_abi.c
index a54424e..67cbfc5 100644
--- a/tools/testing/selftests/vDSO/vdso_test_abi.c
+++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
@@ -182,12 +182,11 @@ int main(int argc, char **argv)
 	unsigned long sysinfo_ehdr =3D getauxval(AT_SYSINFO_EHDR);
=20
 	ksft_print_header();
-	ksft_set_plan(VDSO_TEST_PLAN);
=20
-	if (!sysinfo_ehdr) {
-		ksft_print_msg("AT_SYSINFO_EHDR is not present!\n");
-		return KSFT_SKIP;
-	}
+	if (!sysinfo_ehdr)
+		ksft_exit_skip("AT_SYSINFO_EHDR is not present!\n");
+
+	ksft_set_plan(VDSO_TEST_PLAN);
=20
 	version =3D versions[VDSO_VERSION];
 	name =3D (const char **)&names[VDSO_NAMES];

