Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEE12AA115
	for <lists+linux-tip-commits@lfdr.de>; Sat,  7 Nov 2020 00:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgKFX1R (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 6 Nov 2020 18:27:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38388 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728097AbgKFX1P (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 6 Nov 2020 18:27:15 -0500
Date:   Fri, 06 Nov 2020 23:27:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604705232;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B5IyjPhQQdFFMRsjwnh1tjtHqPuzPCk+VjEqADgUMF0=;
        b=BecthK+s024vaS00aOnhB1FyiifNIOVJ8/M3RT7B89KTOu5fFkJUriye40VePFxGLsVZi9
        n2DdfD87nC/eskX7DQHX5lDlWwLLWjr7Q9KBkx/P2UXUBe+h6PSq6Hzj+X0/4FbjXyzY9r
        SeI9130KAxAR5Nf0biVt9QZSFr8aXquUaQTTlFHDGQzNF+yXjMEGSZAIMihNKuDW0dUC3F
        USGSCwL9mJC9+rXSVTmhti8YzhxZd8pkOGwVO/X+qE6xrOJjW67ybvMWU5rXsOqZeCwEXY
        eSVR21FJDNtS650KHumw8ZU5Frw0c4nJaWKgcjiEj038sugKNYNbG3Kj4tHIXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604705232;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B5IyjPhQQdFFMRsjwnh1tjtHqPuzPCk+VjEqADgUMF0=;
        b=0OIGaGyVozckob2JwjNMiEUmYjPYSAIzjHahrEpyJj4yxdqVnq7TqQFLM7CPd1BNTY7QJV
        DDAGAk8JhKCXWgCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/mm] Documentation/io-mapping: Remove outdated blurb
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201103095858.734064977@linutronix.de>
References: <20201103095858.734064977@linutronix.de>
MIME-Version: 1.0
Message-ID: <160470523160.397.1285623680777934426.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/mm branch of tip:

Commit-ID:     9bf6f7bab3bad4b30f108fca25aa5297dff0973f
Gitweb:        https://git.kernel.org/tip/9bf6f7bab3bad4b30f108fca25aa5297dff0973f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 03 Nov 2020 10:27:33 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 06 Nov 2020 23:14:58 +01:00

Documentation/io-mapping: Remove outdated blurb

The implementation details in the documentation are outdated and not really
helpful. Remove them.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://lore.kernel.org/r/20201103095858.734064977@linutronix.de

---
 Documentation/driver-api/io-mapping.rst | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/Documentation/driver-api/io-mapping.rst b/Documentation/driver-api/io-mapping.rst
index a966239..e33b882 100644
--- a/Documentation/driver-api/io-mapping.rst
+++ b/Documentation/driver-api/io-mapping.rst
@@ -73,25 +73,3 @@ for pages mapped with io_mapping_map_wc.
 At driver close time, the io_mapping object must be freed::
 
 	void io_mapping_free(struct io_mapping *mapping)
-
-Current Implementation
-======================
-
-The initial implementation of these functions uses existing mapping
-mechanisms and so provides only an abstraction layer and no new
-functionality.
-
-On 64-bit processors, io_mapping_create_wc calls ioremap_wc for the whole
-range, creating a permanent kernel-visible mapping to the resource. The
-map_atomic and map functions add the requested offset to the base of the
-virtual address returned by ioremap_wc.
-
-On 32-bit processors with HIGHMEM defined, io_mapping_map_atomic_wc uses
-kmap_atomic_pfn to map the specified page in an atomic fashion;
-kmap_atomic_pfn isn't really supposed to be used with device pages, but it
-provides an efficient mapping for this usage.
-
-On 32-bit processors without HIGHMEM defined, io_mapping_map_atomic_wc and
-io_mapping_map_wc both use ioremap_wc, a terribly inefficient function which
-performs an IPI to inform all processors about the new mapping. This results
-in a significant performance penalty.
