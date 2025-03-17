Return-Path: <linux-tip-commits+bounces-4253-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F28A64A21
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B47F16C0E6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5909023957D;
	Mon, 17 Mar 2025 10:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nBHjDeGZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Aow1ohVI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F02B23875D;
	Mon, 17 Mar 2025 10:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207660; cv=none; b=i2wvJkDmPaiXweGSQ81sdGa2iD8LxqY+kflEvyS8BMT2dsq0weX1c2DyhIkEZQmBxHUU0iVYQoei8M2LMppnEcxv7cdgze1TUjelGQSQ5LH83JFGNooMF6PbzDdPghNOt3Llso3rLFFl5WymQcT6Z4wSco+/8+c144wyKeW9H8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207660; c=relaxed/simple;
	bh=K+MAAu83MnlQNYc/Y/I4Nmy2O7OhGcCCZw7XQitO9Ao=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IeATEQSAlUGolJ2R3aw/4ebsKrMnRNPrPE+Rz6wyaIikzF9irJNvCiy2LTnLLWQHleRKCpghpELxRU3MdD/R79xXMMS4BgKAUA6KP0pmxt4FmJUKisFQaSbHWSBgmhu1EL6WnhIxBNTBvsbPsu9VCMQkf0ZS+nXyLCTm7H6Tjc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nBHjDeGZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Aow1ohVI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 10:34:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742207653;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AmMFzDKBi9Js0RTuzKF0O+tsKKHdbX7WKWJ9lj8hk8U=;
	b=nBHjDeGZmCRgagAYSSFcyxQRVDXn7R35E8Xibg/4QUo8m4WZQAqCYGltcTNN3J3xFA+fjM
	lgOO9v9uqVWqwB0z2lK+vBp+m2fjpOJad+PpMi8eV+UdvL534Pv2VmwQ/R8elVmkUHG2aG
	Z+77v9qxTIjpN8VdY9vG4GiYqy8VAkw3quBNTlRn+3C++PiNrjAXYngDO8B44CjY18lnvg
	IHo/5G0DSu/uZuC/h2gJAm+VoWfCxeJUI1fzsedBIvY1q65Ifym+l/UoaYVjnNr5UuMRqw
	cdBUY4Z9+Cg6YIPgUol/XuEe8HxEt+CO2iNy3zzheElvzbTuW/8+9HpmTXa+CA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742207653;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AmMFzDKBi9Js0RTuzKF0O+tsKKHdbX7WKWJ9lj8hk8U=;
	b=Aow1ohVItlPW7W4KqFw4alzDlKV1tqcWfSxe/61G/A7OW4kmn33t2Zk1jDTm1Zto1sBDjA
	StFLu30b4KTJogAA==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf: Extend per event callchain limit to branch stack
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250310181536.3645382-1-kan.liang@linux.intel.com>
References: <20250310181536.3645382-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220765325.14745.6631883305185568129.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c53e14f1ea4a8f8ddd9b2cd850fcbc0d934b79f5
Gitweb:        https://git.kernel.org/tip/c53e14f1ea4a8f8ddd9b2cd850fcbc0d934b79f5
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 10 Mar 2025 11:15:36 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Mar 2025 11:23:36 +01:00

perf: Extend per event callchain limit to branch stack

The commit 97c79a38cd45 ("perf core: Per event callchain limit")
introduced a per-event term to allow finer tuning of the depth of
callchains to save space.

It should be applied to the branch stack as well. For example, autoFDO
collections require maximum LBR entries. In the meantime, other
system-wide LBR users may only be interested in the latest a few number
of LBRs. A per-event LBR depth would save the perf output buffer.

The patch simply drops the uninterested branches, but HW still collects
the maximum branches. There may be a model-specific optimization that
can reduce the HW depth for some cases to reduce the overhead further.
But it isn't included in the patch set. Because it's not useful for all
cases. For example, ARCH LBR can utilize the PEBS and XSAVE to collect
LBRs. The depth should have less impact on the collecting overhead.
The model-specific optimization may be implemented later separately.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250310181536.3645382-1-kan.liang@linux.intel.com
---
 include/linux/perf_event.h      | 3 +++
 include/uapi/linux/perf_event.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 76f4265..3e27082 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1347,6 +1347,9 @@ static inline void perf_sample_save_brstack(struct perf_sample_data *data,
 
 	if (branch_sample_hw_index(event))
 		size += sizeof(u64);
+
+	brs->nr = min_t(u16, event->attr.sample_max_stack, brs->nr);
+
 	size += brs->nr * sizeof(struct perf_branch_entry);
 
 	/*
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 0524d54..5fc753c 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -385,6 +385,8 @@ enum perf_event_read_format {
  *
  * @sample_max_stack: Max number of frame pointers in a callchain,
  *		      should be < /proc/sys/kernel/perf_event_max_stack
+ *		      Max number of entries of branch stack
+ *		      should be < hardware limit
  */
 struct perf_event_attr {
 

