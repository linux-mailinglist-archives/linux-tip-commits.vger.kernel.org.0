Return-Path: <linux-tip-commits+bounces-7797-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA1ECF490E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 05 Jan 2026 17:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3F990301385A
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jan 2026 16:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38093469E7;
	Mon,  5 Jan 2026 15:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AqwLhaed";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hx386ow+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F998345756;
	Mon,  5 Jan 2026 15:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628467; cv=none; b=Lt/TteFqJ6kaKWJj9R+gvPsrU//32pQyGzi9CMxpC0wB546JnlpCO0orRinaYdE7TaG700Dhq/9TLx4atvnFrT/TEDNEDZscauqq3Ds3XwC/ZwaLoIpdHSLqfeSJZH2urOx3phIQNPZumEOsiEN64uYylJHPqNc/l1tJOaQgHUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628467; c=relaxed/simple;
	bh=TTVRLw63wyeaCDFRAVOAQ6Vxq0xg89u335bLJSnpOpc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AzIH8GWob52m16kBoeDAhL5xIUF+nqLZqiYFqmaAxhiLsI0q8pAIvXLOMALhghVsRzVaffUNMcVlgZADgBgEVKJuxuEyAeZqUTNf5r2wZNBQyO3bk40D6+5MXcntpuyKlfhzcPXkP9Zq1KeJENOL6CDka+Cb33u1vCBiFRpetlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AqwLhaed; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hx386ow+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Jan 2026 15:54:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767628463;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KK4VC3PouEuT9GM5gdgLohoPXuH2rgCUgS4Onqcda8w=;
	b=AqwLhaed54GvVUQiB2EKbExKgQtW1D6DH7AEPdv3tnu2zIukJohbUO1Z/6QoQwOSuBexj7
	VxwFqoVDbvj1/b1RmJIajKOhycte3c25DAdlERWnsBVhTs9nLVBdVtJ3OQx3F46DgMVE3F
	6uZyZVOwr0XT0O6f1W9HY8pOfBUIMpIdaLf8GsS1luf3LUpGFl6UZKyTpH2kClAHKEBxL0
	YWUi6KieArp2lH/PUT1vPLJMBDPDZ6423Gv61kXorGYSxEeZB6fNdbVOsNfEK3rcH+itz6
	uiW7imkb2fkEg7Jk+qe9akCnIWri6O/4qOwQBIhLKMKG1i2pTfnJW6dPVpvlBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767628463;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KK4VC3PouEuT9GM5gdgLohoPXuH2rgCUgS4Onqcda8w=;
	b=Hx386ow+MyQnRf6N/hfNkHgPs+uO4ZfPASDLCtFftcXuh9z2W/+jkYVGfcC1Dt4wwKx8if
	JZgJRYitcRXPtYBQ==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] compiler-context-analysis: Introduce header suppressions
Cc: Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251219154418.3592607-26-elver@google.com>
References: <20251219154418.3592607-26-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176762846195.510.8593296325353613956.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     c237f1ceeef56fa101c2b599a00307b3d690801a
Gitweb:        https://git.kernel.org/tip/c237f1ceeef56fa101c2b599a00307b3d69=
0801a
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 19 Dec 2025 16:40:14 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jan 2026 16:43:33 +01:00

compiler-context-analysis: Introduce header suppressions

While we can opt in individual subsystems which add the required
annotations, such subsystems inevitably include headers from other
subsystems which may not yet have the right annotations, which then
result in false positive warnings.

Making compatible by adding annotations across all common headers
currently requires an excessive number of __no_context_analysis
annotations, or carefully analyzing non-trivial cases to add the correct
annotations. While this is desirable long-term, providing an incremental
path causes less churn and headaches for maintainers not yet interested
in dealing with such warnings.

Rather than clutter headers unnecessary and mandate all subsystem
maintainers to keep their headers working with context analysis,
suppress all -Wthread-safety warnings in headers. Explicitly opt in
headers with context-enabled primitives.

With this in place, we can start enabling the analysis on more complex
subsystems in subsequent changes.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251219154418.3592607-26-elver@google.com
---
 scripts/Makefile.context-analysis        |  4 +++-
 scripts/context-analysis-suppression.txt | 32 +++++++++++++++++++++++-
 2 files changed, 36 insertions(+)
 create mode 100644 scripts/context-analysis-suppression.txt

diff --git a/scripts/Makefile.context-analysis b/scripts/Makefile.context-ana=
lysis
index 70549f7..cd3bb49 100644
--- a/scripts/Makefile.context-analysis
+++ b/scripts/Makefile.context-analysis
@@ -4,4 +4,8 @@ context-analysis-cflags :=3D -DWARN_CONTEXT_ANALYSIS		\
 	-fexperimental-late-parse-attributes -Wthread-safety	\
 	-Wthread-safety-pointer -Wthread-safety-beta
=20
+ifndef CONFIG_WARN_CONTEXT_ANALYSIS_ALL
+context-analysis-cflags +=3D --warning-suppression-mappings=3D$(srctree)/scr=
ipts/context-analysis-suppression.txt
+endif
+
 export CFLAGS_CONTEXT_ANALYSIS :=3D $(context-analysis-cflags)
diff --git a/scripts/context-analysis-suppression.txt b/scripts/context-analy=
sis-suppression.txt
new file mode 100644
index 0000000..df25c3d
--- /dev/null
+++ b/scripts/context-analysis-suppression.txt
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# The suppressions file should only match common paths such as header files.
+# For individual subsytems use Makefile directive CONTEXT_ANALYSIS :=3D [yn].
+#
+# The suppressions are ignored when CONFIG_WARN_CONTEXT_ANALYSIS_ALL is
+# selected.
+
+[thread-safety]
+src:*arch/*/include/*
+src:*include/acpi/*
+src:*include/asm-generic/*
+src:*include/linux/*
+src:*include/net/*
+
+# Opt-in headers:
+src:*include/linux/bit_spinlock.h=3Demit
+src:*include/linux/cleanup.h=3Demit
+src:*include/linux/kref.h=3Demit
+src:*include/linux/list*.h=3Demit
+src:*include/linux/local_lock*.h=3Demit
+src:*include/linux/lockdep.h=3Demit
+src:*include/linux/mutex*.h=3Demit
+src:*include/linux/rcupdate.h=3Demit
+src:*include/linux/refcount.h=3Demit
+src:*include/linux/rhashtable.h=3Demit
+src:*include/linux/rwlock*.h=3Demit
+src:*include/linux/rwsem.h=3Demit
+src:*include/linux/seqlock*.h=3Demit
+src:*include/linux/spinlock*.h=3Demit
+src:*include/linux/srcu*.h=3Demit
+src:*include/linux/ww_mutex.h=3Demit

