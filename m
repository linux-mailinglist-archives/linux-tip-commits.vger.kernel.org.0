Return-Path: <linux-tip-commits+bounces-6821-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A5ABDFC51
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Oct 2025 18:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45B395064D4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Oct 2025 16:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C080F340D83;
	Wed, 15 Oct 2025 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iva6iIkI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Iv/YmYfv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0A033EAFD;
	Wed, 15 Oct 2025 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760547148; cv=none; b=iIJ24G0N0YZrvcOj8urtSg/qn87z3rLr8JWO6uZiyozzDnKt8OZRR76cw9VtBxCYpbDzsb6oZWEhC5HrN5QESBSBg2EGZ35iPVccuyrmfCDYmSYXf/CesIBi0V63lVLHvNIQADTMSMAf/RVMaZzKhJKMHW+cgLRsqbPQ3BDL9sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760547148; c=relaxed/simple;
	bh=4/oyh28nfyNljV3OUuF37t6MwqZ9TG500Dw9PS+I9z4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Vln5wNdFCvAUwIS9Qfd9XL+qTORrRofIfl5EIzMqRKd7klIp/+qrX9uq6Z5Wueliq/FecoyHTMajlhTQbz3Q4KQq0GDKmRb24HXmrHj99PUvGEOkLzQJjSMW0O+67Ed8QeaZPayhvhnDU/Xc2DIaGOFL9Bt7nC8Op/ilZU+e5MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iva6iIkI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Iv/YmYfv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Oct 2025 16:52:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760547144;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sIhW0v6ukAcr5t9xvwFwtYRbmwYaUl9XLTeCP9AKLnE=;
	b=iva6iIkIYTXvrWihfG091AV7rPvKtWSFgyeBPjC8Zl3piulX1oXOd67d4VwQK++qAXgN8g
	9QA5p14mGqWfCwcGP+tihZxzokC8t+tDKLaRZYjHWaXDZRYRaeSUoJOPhKN9UfrPvq4e5a
	+uD79+03BM/vej2FQilZYMev0QfEVdQdXZU3mNjO8BdJfsp/hlz8irnnvNw4pwHfEyqvs1
	8DWKlo1Rj1yehpGW2mjDc741VIA83lb8HhfGdHxy33zg97bvpLl1A8vRxe4zzfcHijUdgi
	aVTk5KTkncgtFItJTqhJ1Z4+OJ24ItVmrqB3ARPSzWaA8LcP7NhJrwFdyNcvAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760547144;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sIhW0v6ukAcr5t9xvwFwtYRbmwYaUl9XLTeCP9AKLnE=;
	b=Iv/YmYfvemjdjzrdd1wbimB/5L13tMQ3SlyiDuu9w9lDpE950Qn+np0tvbJm7SOs9Qbkpx
	UHAMhR5DLn8NXXDw==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Introduce staging step to reduce
 late-loading time
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Chao Gao <chao.gao@intel.com>,
 Tony Luck <tony.luck@intel.com>, Anselm Busse <abusse@amazon.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250921224841.3545-3-chang.seok.bae@intel.com>
References: <20250921224841.3545-3-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176054714292.709179.17479072459906092168.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     7cdda85ed90c1abaccaf5f05ec217acbc102c164
Gitweb:        https://git.kernel.org/tip/7cdda85ed90c1abaccaf5f05ec217acbc10=
2c164
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Sun, 21 Sep 2025 15:48:36 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 15 Oct 2025 16:46:58 +02:00

x86/microcode: Introduce staging step to reduce late-loading time

As microcode patch sizes continue to grow, late-loading latency spikes can
lead to timeouts and disruptions in running workloads. This trend of
increasing patch sizes is expected to continue, so a foundational solution is
needed to address the issue.

To mitigate the problem, introduce a microcode staging feature. This option
processes most of the microcode update (excluding activation) on
a non-critical path, allowing CPUs to remain operational during the majority
of the update. By offloading work from the critical path, staging can
significantly reduce latency spikes.

Integrate staging as a preparatory step in late-loading. Introduce a new
callback for staging, which is invoked at the beginning of
load_late_stop_cpus(), before CPUs enter the rendezvous phase.

Staging follows an opportunistic model:

  *  If successful, it reduces CPU rendezvous time
  *  Even though it fails, the process falls back to the legacy path to
     finish the loading process but with potentially higher latency.

Extend struct microcode_ops to incorporate staging properties, which will be
implemented in the vendor code separately.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Anselm Busse <abusse@amazon.de>
Link: https://lore.kernel.org/20250320234104.8288-1-chang.seok.bae@intel.com
---
 arch/x86/kernel/cpu/microcode/core.c     | 11 +++++++++++
 arch/x86/kernel/cpu/microcode/internal.h |  4 +++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/micro=
code/core.c
index f75c140..d7baec8 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -589,6 +589,17 @@ static int load_late_stop_cpus(bool is_safe)
 		pr_err("You should switch to early loading, if possible.\n");
 	}
=20
+	/*
+	 * Pre-load the microcode image into a staging device. This
+	 * process is preemptible and does not require stopping CPUs.
+	 * Successful staging simplifies the subsequent late-loading
+	 * process, reducing rendezvous time.
+	 *
+	 * Even if the transfer fails, the update will proceed as usual.
+	 */
+	if (microcode_ops->use_staging)
+		microcode_ops->stage_microcode();
+
 	atomic_set(&late_cpus_in, num_online_cpus());
 	atomic_set(&offline_in_nmi, 0);
 	loops_per_usec =3D loops_per_jiffy / (TICK_NSEC / 1000);
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/m=
icrocode/internal.h
index ae8dbc2..a10b547 100644
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -31,10 +31,12 @@ struct microcode_ops {
 	 * See also the "Synchronization" section in microcode_core.c.
 	 */
 	enum ucode_state	(*apply_microcode)(int cpu);
+	void			(*stage_microcode)(void);
 	int			(*collect_cpu_info)(int cpu, struct cpu_signature *csig);
 	void			(*finalize_late_load)(int result);
 	unsigned int		nmi_safe	: 1,
-				use_nmi		: 1;
+				use_nmi		: 1,
+				use_staging	: 1;
 };
=20
 struct early_load_data {

