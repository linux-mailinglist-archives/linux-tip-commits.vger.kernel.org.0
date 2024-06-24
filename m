Return-Path: <linux-tip-commits+bounces-1515-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5607915183
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Jun 2024 17:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E9528AA62
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Jun 2024 15:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C88A19D89E;
	Mon, 24 Jun 2024 15:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Eio7vcyM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dBHkjQW6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F97419CD06;
	Mon, 24 Jun 2024 15:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241767; cv=none; b=mzKYFU+fl6zJNPTlK7fZn/AIDGe/kZzjUeWoSnplepvgApBy2ZA32+CDvZLGE0o1EabzDLXb4nqeK0kwv6Lnr7XndJM9CmSulXyNcfL0sYijSGjrU+jGzub/4wzVAwHoAwRFY0XVQaHYHo2pzNue+sj9uZsoo8rPydWY2nq0slE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241767; c=relaxed/simple;
	bh=BGFtMPkE3a+eQki9sRa7e2AxYIpd/G8am3+KxuughZQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=plwayxdOMfVfwPqBZXPwTtH1Svp+2cN0hCvtgpCDQV/M00976geqoHVzYmy4elp5bh9H7c/EB01LPggPqtW3AE4WxJPscwV4BPTXbv1+wdMmVT68VKohw/h9xxfHJ9NoMabUOW8+XclEb2vOLNmQgjrud9DdwfAhV2WOB3P+D0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Eio7vcyM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dBHkjQW6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Jun 2024 15:09:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719241761;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+FCmtdKnK6lXK3OA8wCxAJ8elBqgB/pCW3YLiuyGlno=;
	b=Eio7vcyM7FTUP6pzN30lsLB5Flt+0zIMPZYCau9NbMz1KbUfdN+hjca5Aforu4bzQ2y949
	lYW7qG7+Ttga+BnJsKqw7UMPEU78OoaCoTaKnhCoSoMT/I9wg8tjQpnmXgEGJBWpBPQhrL
	LYi6KqCEmutBe1vIpnpTu1kRMSessiDm/eM0C/ieSVaaZJxlv+RQKqdFdqoYeaTxM3hZR8
	Xs0DqdEL9flMcAByO2sjRkZXbKCWyoG00Z/ofO4VSqdOx75f6rW8e+2hAfFi2FDwDkOgj6
	bKKE+0HCFOlaAkR15UbJZHVgxRc908U1rbua+1AzQhN288vinU5a18IvoOO61g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719241761;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+FCmtdKnK6lXK3OA8wCxAJ8elBqgB/pCW3YLiuyGlno=;
	b=dBHkjQW6mk2H5+6Valdli+ZACyR3F2fWX9Sef4JhHunjAfKAgwNa805ZB2Apzt9ZKgQTDc
	lgsjQNqhjWFqQ/Bw==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/uncore: Retrieve the unit ID from the unit
 control RB tree
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Yunying Sun <yunying.sun@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240614134631.1092359-4-kan.liang@linux.intel.com>
References: <20240614134631.1092359-4-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171924176094.10875.11909867510224496931.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     585463fee64270d4b4d80b1e433d2105ef555bec
Gitweb:        https://git.kernel.org/tip/585463fee64270d4b4d80b1e433d2105ef555bec
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 14 Jun 2024 06:46:26 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Jun 2024 17:57:56 +02:00

perf/x86/uncore: Retrieve the unit ID from the unit control RB tree

The box_ids only save the unit ID for the first die. If a unit, e.g., a
CXL unit, doesn't exist in the first die. The unit ID cannot be
retrieved.

The unit control RB tree also stores the unit ID information.
Retrieve the unit ID from the unit control RB tree

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Yunying Sun <yunying.sun@intel.com>
Link: https://lore.kernel.org/r/20240614134631.1092359-4-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index f699606..08e85db 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -862,6 +862,9 @@ static const struct attribute_group uncore_pmu_attr_group = {
 static inline int uncore_get_box_id(struct intel_uncore_type *type,
 				    struct intel_uncore_pmu *pmu)
 {
+	if (type->boxes)
+		return intel_uncore_find_discovery_unit_id(type->boxes, -1, pmu->pmu_idx);
+
 	return type->box_ids ? type->box_ids[pmu->pmu_idx] : pmu->pmu_idx;
 }
 

