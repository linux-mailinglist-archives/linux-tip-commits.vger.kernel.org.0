Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8F529E9A3
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 11:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgJ2Kvr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 06:51:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60756 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgJ2Kvq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 06:51:46 -0400
Date:   Thu, 29 Oct 2020 10:51:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603968702;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jteAl4T8bwDadDK9aNP/32hdCbXodwbPmKnA7i0g3nk=;
        b=1QabmFr+jydlfCEfloTwi5aGKrN9ZIkh/1vrpLCxLFAZZAR/mcWskwPGruNyZsX7eHYTN+
        MlEshfr8rtl6pacckhU/JMzE+06OpC+L10MUvfvtCuoY5wwCFuR+EUFuuuNFQF7eOueGH3
        rQPgceXLSx6Gvvd+dNLRwFP59u5VyAlIcwkE/9nMADfDLBERMwSxkaE4wlku3GYNPurYcf
        Amk0yQAkVZOxAOL7i7lMIGC3gH5wMdNB85EQRH8Ltz+cALHWkvEzfeafuCL//1DnyJ/5Co
        1aBXaDq6/sBB1zj2hxg6OubxQRUe1iJE01Sc4NGqemP5SvSGD5DUJTcbXl13TQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603968702;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jteAl4T8bwDadDK9aNP/32hdCbXodwbPmKnA7i0g3nk=;
        b=IMcHLtP3fuB0pBw9T95PbHDp4a320RO6V27XB6qBMO0XCimw4YqIxqyX322Uvi1K/kB2wz
        C6q2sG7RzIznIXAg==
From:   "tip-bot2 for Stephane Eranian" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201001135749.2804-5-kan.liang@linux.intel.com>
References: <20201001135749.2804-5-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <160396870127.397.1765287013032805357.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     995f088efebe1eba0282a6ffa12411b37f8990c2
Gitweb:        https://git.kernel.org/tip/995f088efebe1eba0282a6ffa12411b37f8990c2
Author:        Stephane Eranian <eranian@google.com>
AuthorDate:    Thu, 01 Oct 2020 06:57:49 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 29 Oct 2020 11:00:39 +01:00

perf/core: Add support for PERF_SAMPLE_CODE_PAGE_SIZE

When studying code layout, it is useful to capture the page size of the
sampled code address.

Add a new sample type for code page size.
The new sample type requires collecting the ip. The code page size can
be calculated from the NMI-safe perf_get_page_size().

For large PEBS, it's very unlikely that the mapping is gone for the
earlier PEBS records. Enable the feature for the large PEBS. The worst
case is that page-size '0' is returned.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201001135749.2804-5-kan.liang@linux.intel.com
---
 arch/x86/events/perf_event.h    |  2 +-
 include/linux/perf_event.h      |  1 +
 include/uapi/linux/perf_event.h |  4 +++-
 kernel/events/core.c            | 11 ++++++++++-
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ee2b9b9..10032f0 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -132,7 +132,7 @@ struct amd_nb {
 	PERF_SAMPLE_DATA_SRC | PERF_SAMPLE_IDENTIFIER | \
 	PERF_SAMPLE_TRANSACTION | PERF_SAMPLE_PHYS_ADDR | \
 	PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER | \
-	PERF_SAMPLE_PERIOD)
+	PERF_SAMPLE_PERIOD | PERF_SAMPLE_CODE_PAGE_SIZE)
 
 #define PEBS_GP_REGS			\
 	((1ULL << PERF_REG_X86_AX)    | \
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 7e3785d..e533b03 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1035,6 +1035,7 @@ struct perf_sample_data {
 	u64				phys_addr;
 	u64				cgroup;
 	u64				data_page_size;
+	u64				code_page_size;
 } ____cacheline_aligned;
 
 /* default value for data source */
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index cc6ea34..c2f20ee 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -144,8 +144,9 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_AUX				= 1U << 20,
 	PERF_SAMPLE_CGROUP			= 1U << 21,
 	PERF_SAMPLE_DATA_PAGE_SIZE		= 1U << 22,
+	PERF_SAMPLE_CODE_PAGE_SIZE		= 1U << 23,
 
-	PERF_SAMPLE_MAX = 1U << 23,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 24,		/* non-ABI */
 
 	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
@@ -898,6 +899,7 @@ enum perf_event_type {
 	 *	{ u64			size;
 	 *	  char			data[size]; } && PERF_SAMPLE_AUX
 	 *	{ u64			data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE
+	 *	{ u64			code_page_size;} && PERF_SAMPLE_CODE_PAGE_SIZE
 	 * };
 	 */
 	PERF_RECORD_SAMPLE			= 9,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index a796db2..7f655d1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1898,6 +1898,9 @@ static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
 	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
 		size += sizeof(data->data_page_size);
 
+	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
+		size += sizeof(data->code_page_size);
+
 	event->header_size = size;
 }
 
@@ -6945,6 +6948,9 @@ void perf_output_sample(struct perf_output_handle *handle,
 	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
 		perf_output_put(handle, data->data_page_size);
 
+	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
+		perf_output_put(handle, data->code_page_size);
+
 	if (sample_type & PERF_SAMPLE_AUX) {
 		perf_output_put(handle, data->aux_size);
 
@@ -7125,7 +7131,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 
 	__perf_event_header__init_id(header, data, event);
 
-	if (sample_type & PERF_SAMPLE_IP)
+	if (sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CODE_PAGE_SIZE))
 		data->ip = perf_instruction_pointer(regs);
 
 	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
@@ -7253,6 +7259,9 @@ void perf_prepare_sample(struct perf_event_header *header,
 	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
 		data->data_page_size = perf_get_page_size(data->addr);
 
+	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
+		data->code_page_size = perf_get_page_size(data->ip);
+
 	if (sample_type & PERF_SAMPLE_AUX) {
 		u64 size;
 
