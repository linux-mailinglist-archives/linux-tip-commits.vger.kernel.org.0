Return-Path: <linux-tip-commits+bounces-3723-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 052E2A48A66
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 22:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A5FF188AC6E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 21:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F7826F460;
	Thu, 27 Feb 2025 21:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KfLOkzEc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h6j0FYMj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016C28BEC;
	Thu, 27 Feb 2025 21:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740691497; cv=none; b=HmQTi9tQNl+6WdrNI5CV9N5O6BkSttZM0Pq3u47UVYfcXPxhCW/vURa5BXB0d2xDA/kaUUa5GgCRT9U4lAvqsdh6FPNv6BYIPnpH/0lcC7pwMOZQZvn/c8/Lzn05n37IZIAQ/+tIh0hlIvTNphEmAvSY5z2JjqF+lWgaymnh2x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740691497; c=relaxed/simple;
	bh=I7Gw+VOrI81yKKKEn1hv//pEIL9LNwWod+qYpXQUf9Q=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=H9Y0zEcH51nE1W4gJv4o0DitRzOdNd3bOIWhLY+iv/D6bXmjbZgKSGNfzJ3o1CQ1M0qL1vxyUOsi8/8zdmEfTda1jDLakXHkNxC8m+W5MI/rAWwNtutrz8c7LvW93l/Mk8+igtIM9bl9KV0FSZ6TUJNKu0I528eqG5LGQwl1X4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KfLOkzEc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h6j0FYMj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 21:24:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740691492;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=9pP9b9kojON7jgAl1zqDNk5ddQhlUEqyQo91wqw5eHo=;
	b=KfLOkzEci080xPMVcz3Jh91nB78XZJHH/sL9C9FHW+LoX6YmmShcv0xoWSKkS/Ar2AI3EW
	8G/3d0WxpwrrsNy2LPKobYYZBRyayvw1CZk2aFp35Q5OHYRNoE93w9MXd04LJmDt8Ga93R
	FWE3Jv3GOiIKsA4CpwfafqiNhXp0e5Rf5thn5Zz6wUzmwkyr0EnheSklSp/E5jAHvF4mbc
	KdmjoVPNSWUE+IZJQVX8/7nNT1GvYLPoQJttfnjGatJMQBqXZ5dc6fcvBfLaHraqeOaeoU
	H2JZqYENAosy8u7NVSoB2IHCPFfJldPPy17Rgxm3lW+Bz1rzbnm21DA7kvrhVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740691492;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=9pP9b9kojON7jgAl1zqDNk5ddQhlUEqyQo91wqw5eHo=;
	b=h6j0FYMjcD8vCIU91p5qvwqYgTKv9gdOSIeiQgC9jKnRpXfmfVe/Q0Gpn3SODUbFKDOTkJ
	SmHi5G5Syv7i6lBQ==
From: "tip-bot2 for Max Grobecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Don't clear X86_FEATURE_LAHF_LM flag in
 init_amd_k8() on AMD when running in a virtual machine
Cc: Max Grobecker <max@grobecker.info>, Ingo Molnar <mingo@kernel.org>,
 linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174069148027.10177.17527893236219214276.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     1ec6ddc0d9857b56f1cb3d014395eee6a86923d6
Gitweb:        https://git.kernel.org/tip/1ec6ddc0d9857b56f1cb3d014395eee6a86=
923d6
Author:        Max Grobecker <max@grobecker.info>
AuthorDate:    Thu, 27 Feb 2025 21:45:05 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 Feb 2025 22:07:28 +01:00

x86/cpu: Don't clear X86_FEATURE_LAHF_LM flag in init_amd_k8() on AMD when ru=
nning in a virtual machine

When running in a virtual machine, we might see the original hardware CPU
vendor string (i.e. "AuthenticAMD"), but a model and family ID set by the
hypervisor. In case we run on AMD hardware and the hypervisor sets a model
ID < 0x14, the LAHF cpu feature is eliminated from the the list of CPU
capabilities present to circumvent a bug with some BIOSes in conjunction with
AMD K8 processors.

Parsing the flags list from /proc/cpuinfo seems to be happening mostly in
bash scripts and prebuilt Docker containers, as it does not need to have
additionals tools present =E2=80=93 even though more reliable ways like using=
 "kcpuid",
which calls the CPUID instruction instead of parsing a list, should be prefer=
red.
Scripts, that use /proc/cpuinfo to determine if the current CPU is
"compliant" with defined microarchitecture levels like x86-64-v2 will falsely
claim the CPU is incapable of modern CPU instructions when "lahf_lm" is missi=
ng
in that flags list.

This can prevent some docker containers from starting or build scripts to cre=
ate
unoptimized binaries.

Admittably, this is more a small inconvenience than a severe bug in the kernel
and the shoddy scripts that rely on parsing /proc/cpuinfo
should be fixed instead.

This patch adds an additional check to see if we're running inside a
virtual machine (X86_FEATURE_HYPERVISOR is present), which, to my
understanding, can't be present on a real K8 processor as it was introduced
only with the later/other Athlon64 models.

Example output with the "lahf_lm" flag missing in the flags list
(should be shown between "hypervisor" and "abm"):

    $ cat /proc/cpuinfo
    processor       : 0
    vendor_id       : AuthenticAMD
    cpu family      : 15
    model           : 6
    model name      : Common KVM processor
    stepping        : 1
    microcode       : 0x1000065
    cpu MHz         : 2599.998
    cache size      : 512 KB
    physical id     : 0
    siblings        : 1
    core id         : 0
    cpu cores       : 1
    apicid          : 0
    initial apicid  : 0
    fpu             : yes
    fpu_exception   : yes
    cpuid level     : 13
    wp              : yes
    flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
                      cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx rdt=
scp
                      lm rep_good nopl cpuid extd_apicid tsc_known_freq pni
                      pclmulqdq ssse3 fma cx16 sse4_1 sse4_2 x2apic movbe pop=
cnt
                      tsc_deadline_timer aes xsave avx f16c hypervisor abm
                      3dnowprefetch vmmcall bmi1 avx2 bmi2 xsaveopt

... while kcpuid shows the feature to be present in the CPU:

    # kcpuid -d | grep lahf
         lahf_lm             - LAHF/SAHF available in 64-bit mode

[ mingo: Updated the comment a bit. ]

Signed-off-by: Max Grobecker <max@grobecker.info>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>
---
 arch/x86/kernel/cpu/amd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 54194f5..c1f0a5f 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -631,8 +631,11 @@ static void init_amd_k8(struct cpuinfo_x86 *c)
 	 * Some BIOSes incorrectly force this feature, but only K8 revision D
 	 * (model =3D 0x14) and later actually support it.
 	 * (AMD Erratum #110, docId: 25759).
+	 * Only clear capability flag if we're running on baremetal,
+	 * as we might see a wrong model ID as a guest kernel. In such a case,
+	 * we can safely assume we're not affected by this erratum.
 	 */
-	if (c->x86_model < 0x14 && cpu_has(c, X86_FEATURE_LAHF_LM)) {
+	if (c->x86_model < 0x14 && cpu_has(c, X86_FEATURE_LAHF_LM) && !cpu_has(c, X=
86_FEATURE_HYPERVISOR)) {
 		clear_cpu_cap(c, X86_FEATURE_LAHF_LM);
 		if (!rdmsrl_amd_safe(0xc001100d, &value)) {
 			value &=3D ~BIT_64(32);

