Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452272CA36C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Dec 2020 14:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgLANF6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 1 Dec 2020 08:05:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55368 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgLANF6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 1 Dec 2020 08:05:58 -0500
Date:   Tue, 01 Dec 2020 13:05:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606827916;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mBTSX8F5sTD/fy4j9+ovxyDO3nS/1XWTuFsNr7NpoeA=;
        b=MiKMdzSiuS2h6RR4ryTGvh0YG65nkuc0H28nC3kQavXH46/JDAovNz2rtyXtJ4BuGjFELp
        InWwD/G5iWPNSwXEsVxHcxRAeCPlIXDNPAhHQbPTytElRf0dkTQHNF7xbB0c3/MKdi5ftG
        X/rT8Ymtclq4AmUEp2KRK8EkewocJHiIBXY2hHBbLbNAfx66hB6TmulRMNUBgH0DRIAS7q
        1sUXM54jSZOxME0MNNvxID5glFEiB0fFzRcdrafDCZzNxPHrh4KgyQgGvjiqjeIZdra+vD
        5rkoUWYz2mdzxHN4Hy/jrsbMjQtHKEQXMb3+n4c+TxhWK/XM9nMnpEylyh5K2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606827916;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mBTSX8F5sTD/fy4j9+ovxyDO3nS/1XWTuFsNr7NpoeA=;
        b=x2aOEpkSpRYWd5wugx34PPPw+D1u4b0+nAOtZrE9w5jzkVaM1JFyxiuU8wQt+A+RFaVBOs
        4i8b9LXAd5Q9THCA==
From:   "tip-bot2 for Justin Ernst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Update MAINTAINERS for uv_sysfs driver
Cc:     Justin Ernst <justin.ernst@hpe.com>, Borislav Petkov <bp@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201125175444.279074-6-justin.ernst@hpe.com>
References: <20201125175444.279074-6-justin.ernst@hpe.com>
MIME-Version: 1.0
Message-ID: <160682791526.3364.11222389309836425268.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     6043082c96844fa3a047896212e2da0adc1dde81
Gitweb:        https://git.kernel.org/tip/6043082c96844fa3a047896212e2da0adc1dde81
Author:        Justin Ernst <justin.ernst@hpe.com>
AuthorDate:    Wed, 25 Nov 2020 11:54:44 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 01 Dec 2020 13:59:20 +01:00

x86/platform/uv: Update MAINTAINERS for uv_sysfs driver

Add an entry and email address for the new uv_sysfs driver and
its maintainer.

Signed-off-by: Justin Ernst <justin.ernst@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Steve Wahl <steve.wahl@hpe.com>
Link: https://lkml.kernel.org/r/20201125175444.279074-6-justin.ernst@hpe.com
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a008b70..bcf83e1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18354,6 +18354,12 @@ F:	include/uapi/linux/uuid.h
 F:	lib/test_uuid.c
 F:	lib/uuid.c
 
+UV SYSFS DRIVER
+M:	Justin Ernst <justin.ernst@hpe.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	drivers/platform/x86/uv_sysfs.c
+
 UVESAFB DRIVER
 M:	Michal Januszewski <spock@gentoo.org>
 L:	linux-fbdev@vger.kernel.org
