Return-Path: <linux-tip-commits+bounces-6049-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B27A4AFE86B
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Jul 2025 13:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F112189D9F5
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Jul 2025 11:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D5D2D97B0;
	Wed,  9 Jul 2025 11:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qhr3bixW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/WVUKqvo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F942D663A;
	Wed,  9 Jul 2025 11:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752062099; cv=none; b=cwN3P/ZFBWy+FQ8Ex9+qa8AUtJJCwojUykD012rftggPNSEN7Yp8g2k5oj6jVlIyOzk0+DmbmAjUhWbqdLH+hc3TH6wNPFVohALF/eWZ8f5sao1Doue5c8hKWHZzC/1L6EOJBrgMU2S/9qBACsxXI3hN57fP+eAv6KHNw3fGcy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752062099; c=relaxed/simple;
	bh=Ivj+xB6pm0GqOG/NQronk9gIb7InJsSHFzbSFLomzqY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fPu4oezKXBmL5+I4OHTMn7B/eJs0yfYCx40rWwxzZp/JvDxYDv06S3LNeeDyle4dEE6A/zLnazI4kqC/iuWyPg3Y8D/STIHyfd1Ns5D/U8gnwuQ/Gzmvmi93LZPtXKu25J5JoJpcKlOf49JyO2Z+d8/ovWJqWEW5OgQUeAPSm7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qhr3bixW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/WVUKqvo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Jul 2025 11:54:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752062096;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w4TEb8nKa7W7DCJmMBtCAiuwNfjw2W7mzNkaMIZ7910=;
	b=Qhr3bixWro80Amft3/RoH6isRiJcO86Q408kHr+SFAp5Q7qE/C/Vm6YUehtBRFjpjpOoh7
	vlhXULHdgpAoV+bKk8SzhuDdpeDL3dAh4q//i3mQz2nyVZXeBQKKZVFb1W9akMbQFL8IeN
	+MugShPWSVYaJGowC8SN/9LizmFH8KHFMiI7gUxYCmbv4mGoR18FJzun4FzyRAW6uLlEDb
	PMpmV6FTg5Ymd0/oEaRWOJUlOT1DwILE7b00bD6X35uWin0+ZpbkVNP2yaBJatk32irgXq
	+pWkY8dSeKT0+IqOYKNbW+ZGpruaDF8SWL/MU+MyXm2Jem5tjIinpoiRji5naw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752062096;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w4TEb8nKa7W7DCJmMBtCAiuwNfjw2W7mzNkaMIZ7910=;
	b=/WVUKqvoxKY/I8QdmTYJ0z75aC/V+V36PtbhQuV/hwk8V98hlpGe0kLpVEK+Q1vWhWAIk7
	qwTnzYZWF2ADvxBg==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/intel/uncore: Support customized MMIO map size
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250707201750.616527-3-kan.liang@linux.intel.com>
References: <20250707201750.616527-3-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175206209517.406.12248444876013066902.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     fca24bf2b6b619770d7f1222c0284791d7766239
Gitweb:        https://git.kernel.org/tip/fca24bf2b6b619770d7f1222c0284791d7766239
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 07 Jul 2025 13:17:48 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 09 Jul 2025 13:40:19 +02:00

perf/x86/intel/uncore: Support customized MMIO map size

For a server platform, the MMIO map size is always 0x4000. However, a
client platform may have a smaller map size.

Make the map size customizable.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://lore.kernel.org/r/20250707201750.616527-3-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_discovery.c | 2 +-
 arch/x86/events/intel/uncore_snbep.c     | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 9a78a31..7d57ce7 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -651,7 +651,7 @@ void intel_generic_uncore_mmio_init_box(struct intel_uncore_box *box)
 	}
 
 	addr = unit->addr;
-	box->io_addr = ioremap(addr, UNCORE_GENERIC_MMIO_SIZE);
+	box->io_addr = ioremap(addr, type->mmio_map_size);
 	if (!box->io_addr) {
 		pr_warn("Uncore type %d box %d: ioremap error for 0x%llx.\n",
 			type->type_id, unit->id, (unsigned long long)addr);
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 2824dc9..3a65431 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6409,6 +6409,8 @@ static void uncore_type_customized_copy(struct intel_uncore_type *to_type,
 		to_type->get_topology = from_type->get_topology;
 	if (from_type->cleanup_mapping)
 		to_type->cleanup_mapping = from_type->cleanup_mapping;
+	if (from_type->mmio_map_size)
+		to_type->mmio_map_size = from_type->mmio_map_size;
 }
 
 static struct intel_uncore_type **

