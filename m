Return-Path: <linux-tip-commits+bounces-1902-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0285F9450D9
	for <lists+linux-tip-commits@lfdr.de>; Thu,  1 Aug 2024 18:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B215B282DF3
	for <lists+linux-tip-commits@lfdr.de>; Thu,  1 Aug 2024 16:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A581BC092;
	Thu,  1 Aug 2024 16:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qpft4l4/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g5GUKVmW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901F41BC08F;
	Thu,  1 Aug 2024 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722530135; cv=none; b=mc5EtgGkFccyjmafVLnS8Xa0X4timscAxqjbVdYt0j5BRVlLe6JWadV6O8AaCNIQ1iCRnjShl2B5zeh49C3EWy0tC9ooTqIBVuewXPQ3dEz/qkKFc8QGKm6RS/qHThQ5UYu3PoVghgfL0qxD/3W0vIph4UzTtG/3pNLOUNez97c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722530135; c=relaxed/simple;
	bh=+b5rsB12FATx7WyMVrfcX76RZNwpSNS+gkdy8Kp5zF8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rSShI+USj2LNK2QVyRaGD8NPq2XQKZsz+6oe9sVM3rwlIL+fchbiG9Fq/i0Vb0ihI52GndBX4sYui3s3l1Ja4dAczENbiVNwg8giwLN1+5PAgWY/0rHl511QaQUCvQjxb8l4GJeyH8A4zjpWUFtPRsRNIHsQTRgJKc9XfhQWSWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qpft4l4/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g5GUKVmW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 01 Aug 2024 16:35:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722530131;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PvF7wGe8PvZBoq5ki2duQ68ZhHEZr7eu2n7VrKfWeIM=;
	b=qpft4l4/G8B+uAzl6HyByRg0ED6JOz1YAJKb8YvSjuCtMVdRrpGMFih+kmrj43tAP/maC0
	R3X7O4xKNSNrHeoM+Sz4jXy9OF2mlFlahxzjW+zFcLnRagSUh7ogvW6bnQlWMD/FocSUXO
	LKvcF1sPvONJFpiJWuB2rmxAv5WLhC5iftGj6Sn+28o0ORvZRT5R9tUMUHtDKTcCaxTxWy
	WJG2JIXlYe6TRcYbuH1V/rgP7rTItnl89e5c82DWgzhG6xTVzSmK6EhkYb2qoa7P4lyWly
	1kG8KGHvQPRuje+XOUXTwpVlHcQWIAG3Xgek6g+WRJYqCJK5cixAtTo48N7WDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722530131;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PvF7wGe8PvZBoq5ki2duQ68ZhHEZr7eu2n7VrKfWeIM=;
	b=g5GUKVmWfcop0DU4K60S3VvMDwF8vMo5NxZFdPYtCbciE4ZLpggnwbaSzCjaJbD1JMha0f
	k/RoxFM/GJBtNLDA==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Use mce_prep_record() helpers for
 apei_smca_report_x86_error()
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240730182958.4117158-4-yazen.ghannam@amd.com>
References: <20240730182958.4117158-4-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172253013108.2215.9646933519938640015.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     793aa4bf192d0ad07cca001a596f955d121f5c10
Gitweb:        https://git.kernel.org/tip/793aa4bf192d0ad07cca001a596f955d121f5c10
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Tue, 30 Jul 2024 13:29:58 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 01 Aug 2024 18:20:25 +02:00

x86/mce: Use mce_prep_record() helpers for apei_smca_report_x86_error()

Current AMD systems can report MCA errors using the ACPI Boot Error
Record Table (BERT). The BERT entries for MCA errors will be an x86
Common Platform Error Record (CPER) with an MSR register context that
matches the MCAX/SMCA register space.

However, the BERT will not necessarily be processed on the CPU that
reported the MCA errors. Therefore, the correct CPU number needs to be
determined and the information saved in struct mce.

Use the newly defined mce_prep_record_*() helpers to get the correct
data.

Also, add an explicit check to verify that a valid CPU number was found
from the APIC ID search.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/r/20240730182958.4117158-4-yazen.ghannam@amd.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/mce/apei.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 8f509c8..3885fe0 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -66,6 +66,7 @@ EXPORT_SYMBOL_GPL(apei_mce_report_mem_error);
 int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 {
 	const u64 *i_mce = ((const u64 *) (ctx_info + 1));
+	bool apicid_found = false;
 	unsigned int cpu;
 	struct mce m;
 
@@ -97,20 +98,19 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 	if (ctx_info->reg_arr_size < 48)
 		return -EINVAL;
 
-	mce_prep_record(&m);
-
-	m.extcpu = -1;
-	m.socketid = -1;
-
 	for_each_possible_cpu(cpu) {
 		if (cpu_data(cpu).topo.initial_apicid == lapic_id) {
-			m.extcpu = cpu;
-			m.socketid = cpu_data(m.extcpu).topo.pkg_id;
+			apicid_found = true;
 			break;
 		}
 	}
 
-	m.apicid = lapic_id;
+	if (!apicid_found)
+		return -EINVAL;
+
+	mce_prep_record_common(&m);
+	mce_prep_record_per_cpu(cpu, &m);
+
 	m.bank = (ctx_info->msr_addr >> 4) & 0xFF;
 	m.status = *i_mce;
 	m.addr = *(i_mce + 1);

