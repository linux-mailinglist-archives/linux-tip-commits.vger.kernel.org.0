Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89012CD3C5
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Dec 2020 11:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388722AbgLCKg3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 05:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730151AbgLCKg1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 05:36:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFEDC061A4E;
        Thu,  3 Dec 2020 02:35:46 -0800 (PST)
Date:   Thu, 03 Dec 2020 10:35:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606991744;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GO47bsq5altkHGgrwGq7IzpM1cOgO/G7tHe81NA+H/I=;
        b=nSqkQtE+85USevfLLzmsrGgrT5DuFxEFubUKbC/iD+IsHlO9atj1EgGfVg1ADOoafM3py3
        oJ1g39wVWgFOI88OJFC7P84eDNzYkKp7qwqb7zB8VmNipPV6dHKPokVB9tGXJQl2Z3a3f6
        PJhsPo+5gh7F/+qOP85StiLTIvgmN5Oo75wYsOLqZIOD5v2thP8JEAgbXuSqMke4Dof3ck
        lsjar6SB0EbXxGM4rn6aIOTEJiv+oCykjYVrUmclUsJUUFpNCj/5J1VGVbyyCgqWpbaId+
        06NyStx2ny70EqJa6+Xq1LyS25kb57VC/0RJ4dvbr1P4zLWFlMvMz8ZNqhgn8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606991744;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GO47bsq5altkHGgrwGq7IzpM1cOgO/G7tHe81NA+H/I=;
        b=wgvI4qvDEFHvveuKQcTDTQ/mQrQorqwDPuOmJOf+0fAlf243pfV1wTheNuUTJaIPBnJqZv
        AuDByh5vJ2qIMDCQ==
From:   "tip-bot2 for Mauro Carvalho Chehab" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] refcount: Fix a kernel-doc markup
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cafb9bb1e675bf5f72a34a55d780779d7d5916b4c=2E16068?=
 =?utf-8?q?23973=2Egit=2Emchehab+huawei=40kernel=2Eorg=3E?=
References: =?utf-8?q?=3Cafb9bb1e675bf5f72a34a55d780779d7d5916b4c=2E160682?=
 =?utf-8?q?3973=2Egit=2Emchehab+huawei=40kernel=2Eorg=3E?=
MIME-Version: 1.0
Message-ID: <160699174382.3364.3900529763378502156.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     97d62caa32d6d79dadae3f8d19af5c92ea9a589a
Gitweb:        https://git.kernel.org/tip/97d62caa32d6d79dadae3f8d19af5c92ea9a589a
Author:        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
AuthorDate:    Tue, 01 Dec 2020 13:09:08 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 03 Dec 2020 11:20:52 +01:00

refcount: Fix a kernel-doc markup

The kernel-doc markup is wrong: it is asking the tool to document
struct refcount_struct, instead of documenting typedef refcount_t.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/afb9bb1e675bf5f72a34a55d780779d7d5916b4c.1606823973.git.mchehab+huawei@kernel.org
---
 include/linux/refcount.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index 497990c..b8a6e38 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -101,7 +101,7 @@
 struct mutex;
 
 /**
- * struct refcount_t - variant of atomic_t specialized for reference counts
+ * typedef refcount_t - variant of atomic_t specialized for reference counts
  * @refs: atomic_t counter field
  *
  * The counter saturates at REFCOUNT_SATURATED and will not move once
