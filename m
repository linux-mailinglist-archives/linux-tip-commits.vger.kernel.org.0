Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774F6451D31
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Nov 2021 01:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350350AbhKPAZ5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Nov 2021 19:25:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47068 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350730AbhKOUZh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Nov 2021 15:25:37 -0500
Date:   Mon, 15 Nov 2021 20:22:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637007748;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eSbDPlX01rXtFawt5Zztqv5ADmGl/IdERy16CXlFY4s=;
        b=yE8w0kWltCw9sL/Y9nxmuNpVpHwN8FWXjHL220dOXDqZ92QxcGWS/qaaaGuhTwjZ9y7orc
        9tpB6b5I14lu5EDA47gaGWScpTy6gx2eMXfiF+jxametmghzDRnHS4BtnQ0OlMPHJRzQYu
        leTGWd6yuYHK3ZF46u6q52S9LUAqu5OHIvkumQraCv/HOgSPoOi/PygEy4eFe/rHXVo+s5
        uhXY+iHGs0q6iW4/xxIsTtlxXx66ruDbXbaUR81gu2YfHEnZHqMAj+2PdpvfNBUFLeyNN3
        MjRMAAGijeWeYHHbFYAI1+OiwZEtBacd3PSmYt/iEhfVWrhicKYiojkuTvYvwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637007748;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eSbDPlX01rXtFawt5Zztqv5ADmGl/IdERy16CXlFY4s=;
        b=aRbzdprAzN+N6ykPUZmGGIPK+PDZRV/dloKWX9STP5EIzFF0xfMaQRTbtRx3iKYU9jJ7F3
        I34thHfc6yDXU2AA==
From:   "tip-bot2 for Jarkko Sakkinen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Assign source for each segment
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C7850709c3089fe20e4bcecb8295ba87c54cc2b4a=2E16369?=
 =?utf-8?q?97631=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C7850709c3089fe20e4bcecb8295ba87c54cc2b4a=2E163699?=
 =?utf-8?q?7631=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <163700774785.414.12249055013825439517.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     39f62536be2f6160bba7294b5208e240d34703c3
Gitweb:        https://git.kernel.org/tip/39f62536be2f6160bba7294b5208e240d34703c3
Author:        Jarkko Sakkinen <jarkko@kernel.org>
AuthorDate:    Mon, 15 Nov 2021 10:35:15 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 15 Nov 2021 11:34:00 -08:00

selftests/sgx: Assign source for each segment

Define source per segment so that enclave pages can be added from different
sources, e.g. anonymous VMA for zero pages. In other words, add 'src' field
to struct encl_segment, and assign it to 'encl->src' for pages inherited
from the enclave binary.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/7850709c3089fe20e4bcecb8295ba87c54cc2b4a.1636997631.git.reinette.chatre@intel.com
---
 tools/testing/selftests/sgx/load.c      | 5 +++--
 tools/testing/selftests/sgx/main.h      | 1 +
 tools/testing/selftests/sgx/sigstruct.c | 8 ++++----
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
index 3ebe5d1..5605474 100644
--- a/tools/testing/selftests/sgx/load.c
+++ b/tools/testing/selftests/sgx/load.c
@@ -107,7 +107,7 @@ static bool encl_ioc_add_pages(struct encl *encl, struct encl_segment *seg)
 	memset(&secinfo, 0, sizeof(secinfo));
 	secinfo.flags = seg->flags;
 
-	ioc.src = (uint64_t)encl->src + seg->offset;
+	ioc.src = (uint64_t)seg->src;
 	ioc.offset = seg->offset;
 	ioc.length = seg->size;
 	ioc.secinfo = (unsigned long)&secinfo;
@@ -216,6 +216,7 @@ bool encl_load(const char *path, struct encl *encl)
 
 		if (j == 0) {
 			src_offset = phdr->p_offset & PAGE_MASK;
+			encl->src = encl->bin + src_offset;
 
 			seg->prot = PROT_READ | PROT_WRITE;
 			seg->flags = SGX_PAGE_TYPE_TCS << 8;
@@ -228,13 +229,13 @@ bool encl_load(const char *path, struct encl *encl)
 
 		seg->offset = (phdr->p_offset & PAGE_MASK) - src_offset;
 		seg->size = (phdr->p_filesz + PAGE_SIZE - 1) & PAGE_MASK;
+		seg->src = encl->src + seg->offset;
 
 		j++;
 	}
 
 	assert(j == encl->nr_segments);
 
-	encl->src = encl->bin + src_offset;
 	encl->src_size = encl->segment_tbl[j - 1].offset +
 			 encl->segment_tbl[j - 1].size;
 
diff --git a/tools/testing/selftests/sgx/main.h b/tools/testing/selftests/sgx/main.h
index 68672fd..452d11d 100644
--- a/tools/testing/selftests/sgx/main.h
+++ b/tools/testing/selftests/sgx/main.h
@@ -7,6 +7,7 @@
 #define MAIN_H
 
 struct encl_segment {
+	void *src;
 	off_t offset;
 	size_t size;
 	unsigned int prot;
diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/selftests/sgx/sigstruct.c
index 92bbc5a..202a96f 100644
--- a/tools/testing/selftests/sgx/sigstruct.c
+++ b/tools/testing/selftests/sgx/sigstruct.c
@@ -289,14 +289,14 @@ static bool mrenclave_eextend(EVP_MD_CTX *ctx, uint64_t offset,
 static bool mrenclave_segment(EVP_MD_CTX *ctx, struct encl *encl,
 			      struct encl_segment *seg)
 {
-	uint64_t end = seg->offset + seg->size;
+	uint64_t end = seg->size;
 	uint64_t offset;
 
-	for (offset = seg->offset; offset < end; offset += PAGE_SIZE) {
-		if (!mrenclave_eadd(ctx, offset, seg->flags))
+	for (offset = 0; offset < end; offset += PAGE_SIZE) {
+		if (!mrenclave_eadd(ctx, seg->offset + offset, seg->flags))
 			return false;
 
-		if (!mrenclave_eextend(ctx, offset, encl->src + offset))
+		if (!mrenclave_eextend(ctx, seg->offset + offset, seg->src + offset))
 			return false;
 	}
 
