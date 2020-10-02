Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9647F281D33
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Oct 2020 22:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbgJBU4U (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 2 Oct 2020 16:56:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45304 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBU4R (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 2 Oct 2020 16:56:17 -0400
Date:   Fri, 02 Oct 2020 20:56:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601672174;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f0+D252fCaVDFkg/+i1pA3cU4JJHbiR0kItfJgaoxDU=;
        b=0yq9mmmeddgM0NdKKCHu0oL7/oVGuGS0c248a0XOFFeEm7zJtNI3D0mwdjOQ/EinsjoTld
        v04dckAyfJuj4s6aXppeeJusoBxoi5mCIim+fn2WqHVBxMHyAzYmUZTaCLMpWCRvhfD8Wr
        sOrBspA4y6OmN4a4Y1FQOeiOMUiALLwHz68M4xeqa5pHuLI2Y6WM93fkHU/MuJRN7SSZOp
        uLL12zgKMQfxNPJ7RcQY7VqYEb0bjeo1Msz86+SOBLjwAz2rKOdb/soWUDRZ+YQF3jnsvT
        IcFq+ntEqF0I7nUt98ZN0eX6zFIELc7400BLpXrW13xjv0cPT7WUS1RNnckEuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601672174;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f0+D252fCaVDFkg/+i1pA3cU4JJHbiR0kItfJgaoxDU=;
        b=4mLXvKNfjdAfg5MqeAKGAILbVDuSI0rvUXPuBuqzfT75vKpgG8MHx8FIKyv3IBnzJli7bL
        38/P+g0bQAfKL2Cg==
From:   "tip-bot2 for Heinrich Schuchardt" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] Documentation/x86: Fix incorrect references to
 zero-page.txt
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201002190623.7489-1-xypron.glpk@gmx.de>
References: <20201002190623.7489-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Message-ID: <160167217377.7002.573244513258205543.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     0c7689830e907668288a1a1da84dca66dbdb4728
Gitweb:        https://git.kernel.org/tip/0c7689830e907668288a1a1da84dca66dbdb4728
Author:        Heinrich Schuchardt <xypron.glpk@gmx.de>
AuthorDate:    Fri, 02 Oct 2020 21:06:23 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 02 Oct 2020 22:49:29 +02:00

Documentation/x86: Fix incorrect references to zero-page.txt

The file zero-page.txt does not exit. Add links to zero-page.rst
instead.

 [ bp: Massage a bit. ]

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201002190623.7489-1-xypron.glpk@gmx.de
---
 Documentation/x86/boot.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
index 7fafc7a..abb9fc1 100644
--- a/Documentation/x86/boot.rst
+++ b/Documentation/x86/boot.rst
@@ -1342,8 +1342,8 @@ follow::
 
 In addition to read/modify/write the setup header of the struct
 boot_params as that of 16-bit boot protocol, the boot loader should
-also fill the additional fields of the struct boot_params as that
-described in zero-page.txt.
+also fill the additional fields of the struct boot_params as
+described in chapter :doc:`zero-page`.
 
 After setting up the struct boot_params, the boot loader can load the
 32/64-bit kernel in the same way as that of 16-bit boot protocol.
@@ -1379,7 +1379,7 @@ can be calculated as follows::
 In addition to read/modify/write the setup header of the struct
 boot_params as that of 16-bit boot protocol, the boot loader should
 also fill the additional fields of the struct boot_params as described
-in zero-page.txt.
+in chapter :doc:`zero-page`.
 
 After setting up the struct boot_params, the boot loader can load
 64-bit kernel in the same way as that of 16-bit boot protocol, but
