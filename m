Return-Path: <linux-tip-commits+bounces-6546-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECE7B51B9A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Sep 2025 17:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F259188247D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Sep 2025 15:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75D325394C;
	Wed, 10 Sep 2025 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0UVzIKkM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vf9KIWCy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B51223DF1;
	Wed, 10 Sep 2025 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518141; cv=none; b=kTJc+BFzOC1pusfhWT/Gf58+c6GkBVmBgwOi6TONKNZV5vKeTwbgYBftQ3Ci87nHfvyN5vNPFDVJ3SIT1NKukzitJEQEswo2+UAmsb3g51vRuNF9frosaVoKvgszHswqxIZZ1Pn4SP9wVmX61NXEJ/CzTdaG1TBhlJ2wCzz8BSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518141; c=relaxed/simple;
	bh=Au2nT8WTdMSVo0LlpbRIzVo18Sbjm4DWP3sYOxTT6Ac=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=OMn/Mu8rS1F4UdJ6GjbCm8Q7tZYS9lEoFhtQVUIz0zhSPmn1V4M0MbbG2qfUY1j4V7yuS+mi0S45l9DI+cTgLoGeUje0tT50PKx1Yl4JTmrnh4O8DHZF+fdQMhPjdeDoYjU/g/9TrcqflmqkakmyzKGTRE1FD5+WkC5RnLSrKeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0UVzIKkM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vf9KIWCy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Sep 2025 15:28:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757518138;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Lk93qa4jSTMoC9Z+oKsAX4E36iEr5EO0s7iabVExIiU=;
	b=0UVzIKkMTnybKXG9yJMzMZ2acqTVoJUlvUw8HqXyUfy1PfEYZKvzFnxZVr//93up64MKP4
	Bun4lCMBCfYXIhAL9Ql3uygdAWlepnmkHRZWJzq2roMFfNXlhhaneMwDxXdL4t2VoUDBzS
	7QzO8xM05iXu8YnypKTgdUbNwpgvv/ZX22q57dhZ1NZqWtK9XU2P8ayEeF6CFpPyl3t7wP
	iGWjX4jLQ08kYgb/ExUxF70laLhy0ysrmh/rtaxl4jLgBVxNhx1skD/xT2BV3xolgwIl6J
	YziQPUL30fKQBIoV8wi86x6F2lyUkpfCPm5tobnQCxo4SIC0F4kGTR6MA9Q4fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757518138;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Lk93qa4jSTMoC9Z+oKsAX4E36iEr5EO0s7iabVExIiU=;
	b=Vf9KIWCyXv/KD/AflsrPxJQ7BunTz0NLi2JIZxoBnWoqvgM5xZRbrUFjr7I0dMCrApXkek
	NkuFLZoZBuxWBECA==
From: "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/startup/sev: Document the CPUID flow in the boot
 #VC handler
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175751813665.709179.10650994909607119389.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     8d73829b78ca1a0e6eb93380f3bf5193d58c281c
Gitweb:        https://git.kernel.org/tip/8d73829b78ca1a0e6eb93380f3bf5193d58=
c281c
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Wed, 10 Sep 2025 17:19:28 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 10 Sep 2025 17:23:24 +02:00

x86/startup/sev: Document the CPUID flow in the boot #VC handler

Document the CPUID reading the different SEV guest types do - the SNP
one which relies on the presence of a CPUID table and the SEV-ES one,
which reads the CPUID supplied by the hypervisor.

The intent being to clarify the two back-to-back, similar CPUID
invocations.

No functional changes.

  [ bp: Turn into a proper patch. ]

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/fbb24767-0e06-d1d6-36e0-1757d98aca66@amd.com
---
 arch/x86/boot/startup/sev-shared.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-s=
hared.c
index 08cc156..4e22ffd 100644
--- a/arch/x86/boot/startup/sev-shared.c
+++ b/arch/x86/boot/startup/sev-shared.c
@@ -458,6 +458,13 @@ void do_vc_no_ghcb(struct pt_regs *regs, unsigned long e=
xit_code)
 	leaf.fn =3D fn;
 	leaf.subfn =3D subfn;
=20
+	/*
+	 * If SNP is active, then snp_cpuid() uses the CPUID table to obtain the
+	 * CPUID values (with possible HV interaction during post-processing of
+	 * the values). But if SNP is not active (no CPUID table present), then
+	 * snp_cpuid() returns -EOPNOTSUPP so that an SEV-ES guest can call the
+	 * HV to obtain the CPUID information.
+	 */
 	ret =3D snp_cpuid(snp_cpuid_hv_msr, NULL, &leaf);
 	if (!ret)
 		goto cpuid_done;
@@ -465,6 +472,10 @@ void do_vc_no_ghcb(struct pt_regs *regs, unsigned long e=
xit_code)
 	if (ret !=3D -EOPNOTSUPP)
 		goto fail;
=20
+	/*
+	 * This is reached by a SEV-ES guest and needs to invoke the HV for
+	 * the CPUID data.
+	 */
 	if (__sev_cpuid_hv_msr(&leaf))
 		goto fail;
=20

