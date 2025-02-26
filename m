Return-Path: <linux-tip-commits+bounces-3677-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115B6A45ED3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 13:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D99753A9618
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 12:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CCB21D3E2;
	Wed, 26 Feb 2025 12:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tttzlpG/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J0Fz4Xb/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FA922A4F6;
	Wed, 26 Feb 2025 12:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572114; cv=none; b=cjAqznSJdE8uAuRHXZKwfO+ro17mgiP3LrLxmpO1+EVHBqQi2BWQ33FvBs8ILamdxCNOe3LVjhIVk/g5qgRx5tPI2ZDYzaHBi6mTvTRMMhyvoJMLXxis2iwK3eWeY95+4HuAbX1KkUhVjyllVn8bHBEF7wUn4Kl9DJsyLhCWR6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572114; c=relaxed/simple;
	bh=PAva2RnZ8dQPfOKwJ4JV/ISOfIGnwAtI/XquK1p1Esg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aZarolYjCxM/HXrWDKshQxcf33CYX3ILkkU/JZF/rptSQOXfVhyIVUqWnFs9krJ2yiKaMmr9+Sv4tbW+V9sNk+RRs2WHzDukJz6v+xHV2jQ3nzApthmS3kKHPaMhXFV8NTWdpu2gRz6cY+JI4XmLjaLicaJFAKsF5Qb/ATl2Al8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tttzlpG/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J0Fz4Xb/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 12:15:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740572110;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/Iz5FiE4jbOg6Tn/9G1ReQ5rbKfLc+qGHxpYkUYmVM=;
	b=tttzlpG/MhQ9ptdPMBoX2+HmbBg/M45A5an6c+IIIYtpo/UXNgpuLZoruL8IB419Z83JA3
	NFUpdmv2f6//qhoylphGmbi6fp8EzKMtz8WGCk7nOEW4MyZvjMpE/OgxYYBdZiWrmd8rr4
	tAkYbTkhUWtyTnQcWJiviwz6l6W/hUePNMCo32xbtuVHZBBzv1WPks5CGLLyZN+W3G5Sux
	Fsw1pDRbw5J4NpEuZyTeYts4q7ZdzbuK0+7urxxJ6MeBfrMdlFl/f87f7nlmfH1tpf8QPM
	GE6QYyhspRDQageKe76GQ9fbkx9jPqI0hERMkqnLdh9evyjzYR8rbrJI8ZBPPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740572110;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/Iz5FiE4jbOg6Tn/9G1ReQ5rbKfLc+qGHxpYkUYmVM=;
	b=J0Fz4Xb/b4q/wxuOp+RVtFLLOKjCXwuoFXAoZT4NRsMeJ1tODzk4kVkU4awwDPNJ2/KrlB
	qnnWWK+b1Ovm6jAA==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/fpu] selftests/x86/xstate: Refactor XSAVE helpers for general use
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250226010731.2456-3-chang.seok.bae@intel.com>
References: <20250226010731.2456-3-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174057210937.10177.1459681902178971387.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     0f6d91a327db4a36d6febb74d833cdc668c8661b
Gitweb:        https://git.kernel.org/tip/0f6d91a327db4a36d6febb74d833cdc668c8661b
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Tue, 25 Feb 2025 17:07:22 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 26 Feb 2025 13:05:28 +01:00

selftests/x86/xstate: Refactor XSAVE helpers for general use

The AMX test introduced several XSAVE-related helper functions, but so
far, it has been the only user of them. These helpers can be generalized
for broader test of multiple xstate features.

Move most XSAVE-related code into xsave.h, making it shareable. The
restructuring includes:

 * Establishing low-level XSAVE helpers for saving and restoring register
  states, as well as handling XSAVE buffers.

 * Generalizing state data manipuldations: set_rand_data()

 * Introducing a generic feature query helper: get_xstate_info()

While doing so, remove unused defines in amx.c.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250226010731.2456-3-chang.seok.bae@intel.com
---
 tools/testing/selftests/x86/amx.c    | 142 +-------------------------
 tools/testing/selftests/x86/xstate.h | 132 ++++++++++++++++++++++++-
 2 files changed, 142 insertions(+), 132 deletions(-)
 create mode 100644 tools/testing/selftests/x86/xstate.h

diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index 0f355f3..366cfec 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -19,46 +19,13 @@
 #include <sys/wait.h>
 #include <sys/uio.h>
 
-#include "../kselftest.h" /* For __cpuid_count() */
 #include "helpers.h"
+#include "xstate.h"
 
 #ifndef __x86_64__
 # error This test is 64-bit only
 #endif
 
-#define XSAVE_HDR_OFFSET	512
-#define XSAVE_HDR_SIZE		64
-
-struct xsave_buffer {
-	union {
-		struct {
-			char legacy[XSAVE_HDR_OFFSET];
-			char header[XSAVE_HDR_SIZE];
-			char extended[0];
-		};
-		char bytes[0];
-	};
-};
-
-static inline void xsave(struct xsave_buffer *xbuf, uint64_t rfbm)
-{
-	uint32_t rfbm_lo = rfbm;
-	uint32_t rfbm_hi = rfbm >> 32;
-
-	asm volatile("xsave (%%rdi)"
-		     : : "D" (xbuf), "a" (rfbm_lo), "d" (rfbm_hi)
-		     : "memory");
-}
-
-static inline void xrstor(struct xsave_buffer *xbuf, uint64_t rfbm)
-{
-	uint32_t rfbm_lo = rfbm;
-	uint32_t rfbm_hi = rfbm >> 32;
-
-	asm volatile("xrstor (%%rdi)"
-		     : : "D" (xbuf), "a" (rfbm_lo), "d" (rfbm_hi));
-}
-
 /* err() exits and will not return */
 #define fatal_error(msg, ...)	err(1, "[FAIL]\t" msg, ##__VA_ARGS__)
 
@@ -68,92 +35,12 @@ static inline void xrstor(struct xsave_buffer *xbuf, uint64_t rfbm)
 #define XFEATURE_MASK_XTILEDATA	(1 << XFEATURE_XTILEDATA)
 #define XFEATURE_MASK_XTILE	(XFEATURE_MASK_XTILECFG | XFEATURE_MASK_XTILEDATA)
 
-#define CPUID_LEAF1_ECX_XSAVE_MASK	(1 << 26)
-#define CPUID_LEAF1_ECX_OSXSAVE_MASK	(1 << 27)
-
 static uint32_t xbuf_size;
 
-static struct {
-	uint32_t xbuf_offset;
-	uint32_t size;
-} xtiledata;
-
-#define CPUID_LEAF_XSTATE		0xd
-#define CPUID_SUBLEAF_XSTATE_USER	0x0
-#define TILE_CPUID			0x1d
-#define TILE_PALETTE_ID			0x1
-
-static void check_cpuid_xtiledata(void)
-{
-	uint32_t eax, ebx, ecx, edx;
-
-	__cpuid_count(CPUID_LEAF_XSTATE, CPUID_SUBLEAF_XSTATE_USER,
-		      eax, ebx, ecx, edx);
-
-	/*
-	 * EBX enumerates the size (in bytes) required by the XSAVE
-	 * instruction for an XSAVE area containing all the user state
-	 * components corresponding to bits currently set in XCR0.
-	 *
-	 * Stash that off so it can be used to allocate buffers later.
-	 */
-	xbuf_size = ebx;
-
-	__cpuid_count(CPUID_LEAF_XSTATE, XFEATURE_XTILEDATA,
-		      eax, ebx, ecx, edx);
-	/*
-	 * eax: XTILEDATA state component size
-	 * ebx: XTILEDATA state component offset in user buffer
-	 */
-	if (!eax || !ebx)
-		fatal_error("xstate cpuid: invalid tile data size/offset: %d/%d",
-				eax, ebx);
-
-	xtiledata.size	      = eax;
-	xtiledata.xbuf_offset = ebx;
-}
+struct xstate_info xtiledata;
 
 /* The helpers for managing XSAVE buffer and tile states: */
 
-struct xsave_buffer *alloc_xbuf(void)
-{
-	struct xsave_buffer *xbuf;
-
-	/* XSAVE buffer should be 64B-aligned. */
-	xbuf = aligned_alloc(64, xbuf_size);
-	if (!xbuf)
-		fatal_error("aligned_alloc()");
-	return xbuf;
-}
-
-static inline void clear_xstate_header(struct xsave_buffer *buffer)
-{
-	memset(&buffer->header, 0, sizeof(buffer->header));
-}
-
-static inline void set_xstatebv(struct xsave_buffer *buffer, uint64_t bv)
-{
-	/* XSTATE_BV is at the beginning of the header: */
-	*(uint64_t *)(&buffer->header) = bv;
-}
-
-static void set_rand_tiledata(struct xsave_buffer *xbuf)
-{
-	int *ptr = (int *)&xbuf->bytes[xtiledata.xbuf_offset];
-	int data;
-	int i;
-
-	/*
-	 * Ensure that 'data' is never 0.  This ensures that
-	 * the registers are never in their initial configuration
-	 * and thus never tracked as being in the init state.
-	 */
-	data = rand() | 1;
-
-	for (i = 0; i < xtiledata.size / sizeof(int); i++, ptr++)
-		*ptr = data;
-}
-
 struct xsave_buffer *stashed_xsave;
 
 static void init_stashed_xsave(void)
@@ -169,21 +56,6 @@ static void free_stashed_xsave(void)
 	free(stashed_xsave);
 }
 
-/* See 'struct _fpx_sw_bytes' at sigcontext.h */
-#define SW_BYTES_OFFSET		464
-/* N.B. The struct's field name varies so read from the offset. */
-#define SW_BYTES_BV_OFFSET	(SW_BYTES_OFFSET + 8)
-
-static inline struct _fpx_sw_bytes *get_fpx_sw_bytes(void *buffer)
-{
-	return (struct _fpx_sw_bytes *)(buffer + SW_BYTES_OFFSET);
-}
-
-static inline uint64_t get_fpx_sw_bytes_features(void *buffer)
-{
-	return *(uint64_t *)(buffer + SW_BYTES_BV_OFFSET);
-}
-
 /* Work around printf() being unsafe in signals: */
 #define SIGNAL_BUF_LEN 1000
 char signal_message_buffer[SIGNAL_BUF_LEN];
@@ -281,7 +153,7 @@ static inline bool load_rand_tiledata(struct xsave_buffer *xbuf)
 {
 	clear_xstate_header(xbuf);
 	set_xstatebv(xbuf, XFEATURE_MASK_XTILEDATA);
-	set_rand_tiledata(xbuf);
+	set_rand_data(&xtiledata, xbuf);
 	return xrstor_safe(xbuf, XFEATURE_MASK_XTILEDATA);
 }
 
@@ -884,7 +756,13 @@ int main(void)
 		return KSFT_SKIP;
 	}
 
-	check_cpuid_xtiledata();
+	xbuf_size = get_xbuf_size();
+
+	xtiledata = get_xstate_info(XFEATURE_XTILEDATA);
+	if (!xtiledata.size || !xtiledata.xbuf_offset) {
+		fatal_error("xstate cpuid: invalid tile data size/offset: %d/%d",
+			    xtiledata.size, xtiledata.xbuf_offset);
+	}
 
 	init_stashed_xsave();
 	sethandler(SIGILL, handle_noperm, 0);
diff --git a/tools/testing/selftests/x86/xstate.h b/tools/testing/selftests/x86/xstate.h
new file mode 100644
index 0000000..6729ffd
--- /dev/null
+++ b/tools/testing/selftests/x86/xstate.h
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#ifndef __SELFTESTS_X86_XSTATE_H
+#define __SELFTESTS_X86_XSTATE_H
+
+#include <stdint.h>
+
+#include "../kselftest.h"
+
+#define XSAVE_HDR_OFFSET	512
+#define XSAVE_HDR_SIZE		64
+
+struct xsave_buffer {
+	union {
+		struct {
+			char legacy[XSAVE_HDR_OFFSET];
+			char header[XSAVE_HDR_SIZE];
+			char extended[0];
+		};
+		char bytes[0];
+	};
+};
+
+static inline void xsave(struct xsave_buffer *xbuf, uint64_t rfbm)
+{
+	uint32_t rfbm_hi = rfbm >> 32;
+	uint32_t rfbm_lo = rfbm;
+
+	asm volatile("xsave (%%rdi)"
+		     : : "D" (xbuf), "a" (rfbm_lo), "d" (rfbm_hi)
+		     : "memory");
+}
+
+static inline void xrstor(struct xsave_buffer *xbuf, uint64_t rfbm)
+{
+	uint32_t rfbm_hi = rfbm >> 32;
+	uint32_t rfbm_lo = rfbm;
+
+	asm volatile("xrstor (%%rdi)"
+		     : : "D" (xbuf), "a" (rfbm_lo), "d" (rfbm_hi));
+}
+
+#define CPUID_LEAF_XSTATE		0xd
+#define CPUID_SUBLEAF_XSTATE_USER	0x0
+
+static inline uint32_t get_xbuf_size(void)
+{
+	uint32_t eax, ebx, ecx, edx;
+
+	__cpuid_count(CPUID_LEAF_XSTATE, CPUID_SUBLEAF_XSTATE_USER,
+		      eax, ebx, ecx, edx);
+
+	/*
+	 * EBX enumerates the size (in bytes) required by the XSAVE
+	 * instruction for an XSAVE area containing all the user state
+	 * components corresponding to bits currently set in XCR0.
+	 */
+	return ebx;
+}
+
+struct xstate_info {
+	uint32_t num;
+	uint32_t mask;
+	uint32_t xbuf_offset;
+	uint32_t size;
+};
+
+static inline struct xstate_info get_xstate_info(uint32_t xfeature_num)
+{
+	struct xstate_info xstate = { };
+	uint32_t eax, ebx, ecx, edx;
+
+	xstate.num  = xfeature_num;
+	xstate.mask = 1 << xfeature_num;
+
+	__cpuid_count(CPUID_LEAF_XSTATE, xfeature_num,
+		      eax, ebx, ecx, edx);
+	xstate.size        = eax;
+	xstate.xbuf_offset = ebx;
+	return xstate;
+}
+
+static inline struct xsave_buffer *alloc_xbuf(void)
+{
+	uint32_t xbuf_size = get_xbuf_size();
+
+	/* XSAVE buffer should be 64B-aligned. */
+	return aligned_alloc(64, xbuf_size);
+}
+
+static inline void clear_xstate_header(struct xsave_buffer *xbuf)
+{
+	memset(&xbuf->header, 0, sizeof(xbuf->header));
+}
+
+static inline void set_xstatebv(struct xsave_buffer *xbuf, uint64_t bv)
+{
+	/* XSTATE_BV is at the beginning of the header: */
+	*(uint64_t *)(&xbuf->header) = bv;
+}
+
+/* See 'struct _fpx_sw_bytes' at sigcontext.h */
+#define SW_BYTES_OFFSET		464
+/* N.B. The struct's field name varies so read from the offset. */
+#define SW_BYTES_BV_OFFSET	(SW_BYTES_OFFSET + 8)
+
+static inline struct _fpx_sw_bytes *get_fpx_sw_bytes(void *xbuf)
+{
+	return xbuf + SW_BYTES_OFFSET;
+}
+
+static inline uint64_t get_fpx_sw_bytes_features(void *buffer)
+{
+	return *(uint64_t *)(buffer + SW_BYTES_BV_OFFSET);
+}
+
+static inline void set_rand_data(struct xstate_info *xstate, struct xsave_buffer *xbuf)
+{
+	int *ptr = (int *)&xbuf->bytes[xstate->xbuf_offset];
+	int data, i;
+
+	/*
+	 * Ensure that 'data' is never 0.  This ensures that
+	 * the registers are never in their initial configuration
+	 * and thus never tracked as being in the init state.
+	 */
+	data = rand() | 1;
+
+	for (i = 0; i < xstate->size / sizeof(int); i++, ptr++)
+		*ptr = data;
+}
+
+#endif /* __SELFTESTS_X86_XSTATE_H */

