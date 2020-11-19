Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B50A2B9050
	for <lists+linux-tip-commits@lfdr.de>; Thu, 19 Nov 2020 11:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgKSKm1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 19 Nov 2020 05:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgKSKm1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 19 Nov 2020 05:42:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E78DC0613CF;
        Thu, 19 Nov 2020 02:42:27 -0800 (PST)
Date:   Thu, 19 Nov 2020 10:42:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605782545;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A5TBILm8EDUVeTjpNQ2kHXodQpKOEylhGT+OwEO0vU8=;
        b=cP9YSJ2LareyAocolymPZqpR4i61iKDUqBYxrjKk6ZKer4lhlYfAb/herXGUqNYC9LnprO
        8Ag2cQeInqiB0eCsb7cTKlz02rUfnOokIAskpq82HBX/bemnMEQi/mf7GUu2dL0AW19Sx9
        i9aY5ebZRsvxeZITWrI63wVfHKrzoNkE34hI09j6SeJ4Anu6kUhzKqJVkiiJoZkYkGgDQJ
        /Wd/u6+ohoWT3sf+dDHEy4rm5RIpKndkTy3DOFMv4yV5kYK/HJyuXWBlexUj6g3wr7tCdW
        V7TGqh87Klw9tKgaP3VRG7tt85GwL3TkZwAhdhi6PdEoWlfl8ttcaqeGKZVPkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605782545;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A5TBILm8EDUVeTjpNQ2kHXodQpKOEylhGT+OwEO0vU8=;
        b=l8jdoVaNtIpIlsdWz03V1DDgnAE54/uVUvCbi67El86CEbWlgarnBL55G4anMxtJ3fnavu
        oPAPDE7ibAPm7cBQ==
From:   "tip-bot2 for Jarkko Sakkinen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Return -ERESTARTSYS in sgx_ioc_enclave_add_pages()
Cc:     Haitao Huang <haitao.huang@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201118213932.63341-1-jarkko@kernel.org>
References: <20201118213932.63341-1-jarkko@kernel.org>
MIME-Version: 1.0
Message-ID: <160578254433.11244.9036967823695962289.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     14132a5b807bb5caf778fe7ae1597e630971e949
Gitweb:        https://git.kernel.org/tip/14132a5b807bb5caf778fe7ae1597e630971e949
Author:        Jarkko Sakkinen <jarkko@kernel.org>
AuthorDate:    Wed, 18 Nov 2020 23:39:32 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 19 Nov 2020 10:51:24 +01:00

x86/sgx: Return -ERESTARTSYS in sgx_ioc_enclave_add_pages()

Return -ERESTARTSYS instead of -EINTR in sgx_ioc_enclave_add_pages()
when interrupted before any pages have been processed. At this point
ioctl can be obviously safely restarted.

Reported-by: Haitao Huang <haitao.huang@intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201118213932.63341-1-jarkko@kernel.org
---
 arch/x86/kernel/cpu/sgx/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 6d37117..30aefc9 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -444,7 +444,7 @@ static long sgx_ioc_enclave_add_pages(struct sgx_encl *encl, void __user *arg)
 	for (c = 0 ; c < add_arg.length; c += PAGE_SIZE) {
 		if (signal_pending(current)) {
 			if (!c)
-				ret = -EINTR;
+				ret = -ERESTARTSYS;
 
 			break;
 		}
