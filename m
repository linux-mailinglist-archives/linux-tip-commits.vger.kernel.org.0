Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDA8361E5E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Apr 2021 13:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239201AbhDPLDH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 16 Apr 2021 07:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239124AbhDPLDG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 16 Apr 2021 07:03:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453F0C061574;
        Fri, 16 Apr 2021 04:02:42 -0700 (PDT)
Date:   Fri, 16 Apr 2021 11:02:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618570959;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1NTq85TALNdAJUlr0whA/xffrxvSuts2Os+sT7GZrto=;
        b=VPFXPsnv7XFzwVTlac6xeApDq01PVT5KBlmPg6EyLYhTosa9H/SmmodE33J2D/Wp/dBzNs
        sq14tKsltmGt8deYgrCcG7j3DcWZTyGzDAwkza/p5bhg3yJ8I1MG54JNgwkCs8zTFy82ia
        +y8tDtowYTzvDPE7mIcI2Vuy4e0t7SC7+bJIxRe8Hot44D+DFF8yP0q6hg/G/UXQZkDQAc
        mA+2OWghwc0nHu8I+sda3w5ekIs/Vw4TkzG2FGbrg4/+vXNEzu9UEFj3UOD55MynJpEj4y
        FL/18zk0OqVdKf6hGD5Rt0xX+OAf8eeIEVg6xjk5JPU7elxAWE/kGrQoT0P5Ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618570959;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1NTq85TALNdAJUlr0whA/xffrxvSuts2Os+sT7GZrto=;
        b=mOZxVYbnRe0uL05wYKegVYtheS7yuGLizUG0NiOGveo2YU+N991f6Lg+D4GJMUf0DsPjsY
        1nu0l8mf6Z1G3FBw==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] MAINTAINERS: Remove me from IDE/ATAPI section
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210412090346.31213-1-bp@alien8.de>
References: <20210412090346.31213-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <161857095879.29796.7220918914787440943.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     df448cdfc01ffc117702a494ef302e7fb76df78a
Gitweb:        https://git.kernel.org/tip/df448cdfc01ffc117702a494ef302e7fb76df78a
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Mon, 12 Apr 2021 10:59:51 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 16 Apr 2021 12:58:34 +02:00

MAINTAINERS: Remove me from IDE/ATAPI section

It has been years since I've touched this and "this" is going away
anyway... any day now. :-)

So remove me so that I do not get CCed on bugs/patches.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210412090346.31213-1-bp@alien8.de
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9e87692..93215a6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8603,9 +8603,8 @@ F:	drivers/ide/
 F:	include/linux/ide.h
 
 IDE/ATAPI DRIVERS
-M:	Borislav Petkov <bp@alien8.de>
 L:	linux-ide@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	Documentation/cdrom/ide-cd.rst
 F:	drivers/ide/ide-cd*
 
