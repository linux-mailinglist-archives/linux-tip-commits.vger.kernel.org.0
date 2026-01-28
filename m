Return-Path: <linux-tip-commits+bounces-8123-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFDlFtvJeWkezgEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8123-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 09:33:31 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B90569E3E4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 09:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6DBA3012CD6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 08:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4B229A1;
	Wed, 28 Jan 2026 08:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jYmZEleL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qrejFL/u"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA59F26CE2D;
	Wed, 28 Jan 2026 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769589207; cv=none; b=o3w5qGFEAE1il7WZ+5B7F+KxYcmToC/NQvnHr0oHLsBpfz54IhMYvsKeONIiINhEGmzEKKyJ2K0d56ElkpA8dGKUMQQ/NZwLYSrt37yFG229x/INYQH2Dbzuld34IaOenNkzqrRcjQj+ihsVlrptd2rwe7oIXFnu3q72qsfJLyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769589207; c=relaxed/simple;
	bh=YvUGfupRRJaMrdrbs4fOB7Rr5ixZ3YV4YLU0+0LAdBM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eLU/HAlnjXE+lrPe4M5rYdKJzJudYzJxKx+Nyc1oV5j1S6dVVjCDAZweVTDsOfn16WsMjK1ABN/9YN14GWX6dk8RWSFEcSwtmqoaUHwlfC9JDgqsbH6kP0kCa/8qpY+eFyicupNxtDHmXui3pwVvz+uyM3rruZuP5RJ2JL+RhcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jYmZEleL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qrejFL/u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Jan 2026 08:33:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769589203;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DWT8TV68aMaCjDVTxKQF+cGBS01qRMSWpnanvmowISI=;
	b=jYmZEleLZmQ8KF9raLw1n8+6wAVYAO/aWdzW143XloCwbGpBTTwLDPrwaIk9Vv0RdNgyaQ
	Fr34EvL4xqSWf+S3cY0Q5v/9xI3BQrLmastnAILbXo+Ma9hEXkoHDd5Zk8t48UP/VXf+LG
	TX/zF0iFtYNBfNTPpw1Hwb4/vktSE7m1O8B7bTdm7dmPiXOl73yYyARTSZELbcoDARITDW
	WHL/0jOvPKdyDzrFOk+vV9GlHg45bKS/mPilraJCmabDf5wLEugm1AQUBEAYJoHiHnQzIA
	ykAsit8fm+6+repH/eddqRfWwQV3DChXlWXZkwsPs1/opqtY/dH0x3tAKWtToQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769589203;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DWT8TV68aMaCjDVTxKQF+cGBS01qRMSWpnanvmowISI=;
	b=qrejFL/uwnejj4iQZE+xd07eaHH16L54GhgCi1E9UIdGaYV5eZkPUHL/qwuW01CMGTLg9G
	VJzv2Pq+jcMLY6BQ==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] tools: Update context analysis macros in compiler_types.h
Cc: kernel test robot <oliver.sang@intel.com>, Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260127111428.3747328-1-elver@google.com>
References: <20260127111428.3747328-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176958919944.510.6077079080627294191.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8123-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: B90569E3E4
X-Rspamd-Action: no action

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     944e3f7562c55fa37ebcdd58e5f60f296c81a854
Gitweb:        https://git.kernel.org/tip/944e3f7562c55fa37ebcdd58e5f60f296c8=
1a854
Author:        Marco Elver <elver@google.com>
AuthorDate:    Tue, 27 Jan 2026 12:12:06 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 28 Jan 2026 09:25:45 +01:00

tools: Update context analysis macros in compiler_types.h

In sync with the main kernel headers, include a stub version of
compiler-context-analysis.h in tools/include/linux/compiler_types.h and
remove the sparse context tracking definitions.

Since tools/ headers are generally self-contained, provide a standalone
tools/include/linux/compiler-context-analysis.h with no-op stubs for now. Also
clean up redundant stubs in tools/testing/shared/linux/kernel.h that are now
redundant.

This fixes build errors in tools/testing/radix-tree/ where headers from
include/linux/ (like cleanup.h) are used directly and expect these
macros to be defined:

| cc -I../shared -I. -I../../include -I../../arch/x86/include -I../../../lib =
-g -Og -Wall -D_LGPL_SOURCE -fsanitize=3Daddress -fsanitize=3Dundefined    -c=
 -o radix-tree.o radix-tree.c
| In file included from ../shared/linux/cleanup.h:2,
|                  from ../shared/linux/../../../../include/linux/idr.h:18,
|                  from ../shared/linux/idr.h:5,
|                  from radix-tree.c:18:
| ../shared/linux/../../../../include/linux/idr.h: In function =E2=80=98class=
_idr_alloc_destructor=E2=80=99:
| ../shared/linux/../../../../include/linux/cleanup.h:283:9: error: expected =
declaration specifiers before =E2=80=98__no_context_analysis=E2=80=99
|   283 |         __no_context_analysis                                      =
     \
|       |         ^~~~~~~~~~~~~~~~~~~~~

Closes: https://lore.kernel.org/oe-lkp/202601261546.d7ae2447-lkp@intel.com
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Tested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Link: https://patch.msgid.link/20260127111428.3747328-1-elver@google.com
---
 tools/include/linux/compiler-context-analysis.h | 42 ++++++++++++++++-
 tools/include/linux/compiler_types.h            | 16 +------
 tools/testing/shared/linux/kernel.h             |  4 +--
 3 files changed, 43 insertions(+), 19 deletions(-)
 create mode 100644 tools/include/linux/compiler-context-analysis.h

diff --git a/tools/include/linux/compiler-context-analysis.h b/tools/include/=
linux/compiler-context-analysis.h
new file mode 100644
index 0000000..13a9115
--- /dev/null
+++ b/tools/include/linux/compiler-context-analysis.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOOLS_LINUX_COMPILER_CONTEXT_ANALYSIS_H
+#define _TOOLS_LINUX_COMPILER_CONTEXT_ANALYSIS_H
+
+/*
+ * Macros and attributes for compiler-based static context analysis.
+ * No-op stubs for tools.
+ */
+
+#define __guarded_by(...)
+#define __pt_guarded_by(...)
+
+#define context_lock_struct(name, ...)	struct __VA_ARGS__ name
+
+#define __no_context_analysis
+#define __context_unsafe(comment)
+#define context_unsafe(...)		({ __VA_ARGS__; })
+#define context_unsafe_alias(p)
+#define disable_context_analysis()
+#define enable_context_analysis()
+
+#define __must_hold(...)
+#define __must_not_hold(...)
+#define __acquires(...)
+#define __cond_acquires(ret, x)
+#define __releases(...)
+#define __acquire(x)			(void)0
+#define __release(x)			(void)0
+
+#define __must_hold_shared(...)
+#define __acquires_shared(...)
+#define __cond_acquires_shared(ret, x)
+#define __releases_shared(...)
+#define __acquire_shared(x)		(void)0
+#define __release_shared(x)		(void)0
+
+#define __acquire_ret(call, expr)	(call)
+#define __acquire_shared_ret(call, expr) (call)
+#define __acquires_ret
+#define __acquires_shared_ret
+
+#endif /* _TOOLS_LINUX_COMPILER_CONTEXT_ANALYSIS_H */
diff --git a/tools/include/linux/compiler_types.h b/tools/include/linux/compi=
ler_types.h
index 067a5b4..14e4204 100644
--- a/tools/include/linux/compiler_types.h
+++ b/tools/include/linux/compiler_types.h
@@ -13,21 +13,7 @@
 #define __has_builtin(x) (0)
 #endif
=20
-#ifdef __CHECKER__
-/* context/locking */
-# define __must_hold(x)	__attribute__((context(x,1,1)))
-# define __acquires(x)	__attribute__((context(x,0,1)))
-# define __releases(x)	__attribute__((context(x,1,0)))
-# define __acquire(x)	__context__(x,1)
-# define __release(x)	__context__(x,-1)
-#else /* __CHECKER__ */
-/* context/locking */
-# define __must_hold(x)
-# define __acquires(x)
-# define __releases(x)
-# define __acquire(x)	(void)0
-# define __release(x)	(void)0
-#endif /* __CHECKER__ */
+#include <linux/compiler-context-analysis.h>
=20
 /* Compiler specific macros. */
 #ifdef __GNUC__
diff --git a/tools/testing/shared/linux/kernel.h b/tools/testing/shared/linux=
/kernel.h
index c0a2bb7..dc2b4cc 100644
--- a/tools/testing/shared/linux/kernel.h
+++ b/tools/testing/shared/linux/kernel.h
@@ -21,9 +21,5 @@
 #define schedule()
 #define PAGE_SHIFT	12
=20
-#define __acquires(x)
-#define __releases(x)
-#define __must_hold(x)
-
 #define EXPORT_PER_CPU_SYMBOL_GPL(x)
 #endif /* _KERNEL_H */

