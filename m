Return-Path: <linux-tip-commits+bounces-5970-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 021CAAEFB8F
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Jul 2025 16:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4BD47B62C3
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Jul 2025 14:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E679280A35;
	Tue,  1 Jul 2025 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sMfXRs5V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jKLdomY1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7946278750;
	Tue,  1 Jul 2025 13:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751378362; cv=none; b=jAK8ysRbpQw2L6BCU7fXsmGSNPMEDyf+0q5xE3P1irfUz83mliPvJkzj26+7RiFwsx9WRpHkxrHq3lHHA35DzqRsDO/8GhlwMxpHLRmCuql5app8gDs7Wauq0kMet78GewafGiPia6XkkHBW3EMmzuT4VDfGVtmG/QQhrppyY3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751378362; c=relaxed/simple;
	bh=ZYlFIuJ9xjsXgbjaUrqR9fe70pBDhqNvCi+XyuC6KaA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UcppwTIdZwt0nKcVhPjwBpM62nmC18OUqE+TaPcHahsP+1J+W50zO2VwpIBwKmKR5NtKCw7jOm8SxxAyEzhphOwaBcsI9YCAqIbU2n+vqPWtY3R9j7BM0Ge4zCSOM9mRSwI4IKFqmMFsOUch6E+ivszjvOykS8ELDkq9SGI1GVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sMfXRs5V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jKLdomY1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 01 Jul 2025 13:59:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751378358;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1+fmVvtYgfi+RlZix9rkjaQLJvkasxVjvfA0i7yIgHw=;
	b=sMfXRs5V7LUh5nXGYw/RD+cCceR/tiDezGzPz8YRTbiamsLi9+1f7953/aT9OpL7dm/KD4
	/+RTf6c8WqNJ01kZmFw9KPAOn3+5skXf6+HePau9wuz8aP5qQybjPec/jJxCbBUf5NruwZ
	yU2QXjNXTfjx+Rcfq1lXSd4e2FPT8b2QGIyLnvS3osjR03nKa70ij9p3Hpvf7mnqJ5j7eW
	BBwaGppxhvfZVq7N3yHg15VfXUD23flK6QCTguTikc8GMj2ggYgKlUQDxYO6dOv6miN2kb
	sXXWvrrPAUWaOAT481QRfc/y6c4S1056szUSrr1ZYnd3i1kMq+/QFgQAvwqkvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751378358;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1+fmVvtYgfi+RlZix9rkjaQLJvkasxVjvfA0i7yIgHw=;
	b=jKLdomY1vsK4vNSFuNwwsaoK4AplYEnrkl6Yo22Y2HiCPRaTvNWE42iLIMM0mBb6rDps/f
	xJZ4OyPQivADkGBA==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] selftests: vDSO: vdso_test_getrandom: Avoid -Wunused
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250611-selftests-vdso-fixes-v3-4-e62e37a6bcf5@linutronix.de>
References: <20250611-selftests-vdso-fixes-v3-4-e62e37a6bcf5@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175137835767.406.987004392563431322.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     b8ae430871254f95dd81dcff01828be3f6b24a57
Gitweb:        https://git.kernel.org/tip/b8ae430871254f95dd81dcff01828be3f6b=
24a57
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Wed, 11 Jun 2025 12:33:54 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 01 Jul 2025 15:50:42 +02:00

selftests: vDSO: vdso_test_getrandom: Avoid -Wunused

vgetrandom_put_state() and the variable "ret" in kselftest() are unused.

Drop the variable "ret". Suppress the warning for  vgetrandom_put_state()
as it is meant as an example for libc implementors.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250611-selftests-vdso-fixes-v3-4-e62e37a6=
bcf5@linutronix.de

---
 tools/testing/selftests/vDSO/vdso_test_getrandom.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c b/tools/testi=
ng/selftests/vDSO/vdso_test_getrandom.c
index f36e50f..389ead4 100644
--- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
+++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
@@ -100,6 +100,7 @@ out:
 	return state;
 }
=20
+__attribute__((unused)) /* Example for libc implementors */
 static void vgetrandom_put_state(void *state)
 {
 	if (!state)
@@ -264,7 +265,7 @@ static void kselftest(void)
 	}
 	for (;;) {
 		struct ptrace_syscall_info info =3D { 0 };
-		int status, ret;
+		int status;
 		ksft_assert(waitpid(child, &status, 0) >=3D 0);
 		if (WIFEXITED(status)) {
 			ksft_assert(WEXITSTATUS(status) =3D=3D 0);

