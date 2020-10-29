Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3299F29EB81
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 13:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgJ2MQU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 08:16:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33326 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgJ2MPw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 08:15:52 -0400
Date:   Thu, 29 Oct 2020 12:15:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603973750;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=xKs1HzOoAjuYgKYm19j8099Mxc4VD9MsDSxYYXBQhfA=;
        b=VebtIo/7foG+E/TKdxrqWTwwRwqw1s3nvol6ko5LxYvtz1pp78/JkoSW5uuqzCrM3V6ngc
        44R6AecQ4XNQzEu1mPN3ukc789rVNMSZXr1gBc93Ruv03mgNqozAwQOzoFV943UtDy4t7V
        qd8KlohkV2HAW2xUIEpfebbGNsjiAfgUxwNsN6VAldWd29/LmXnBsvtw7QRXGhr/IWpCn7
        TuPpCVduIH3cGRVW0NeF2Mtt4kmO2pyUYyR77RhobY9DSLrr4vnFBKu276nSbtVUtj6fmY
        9oWFXGhKAIoCitCAGTWbtk16fuKvA2a5ahVErHTodcEyvgnYY12JTI/d2Ir5ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603973750;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=xKs1HzOoAjuYgKYm19j8099Mxc4VD9MsDSxYYXBQhfA=;
        b=s1tkuIrz+EgUhX4XM4cCDQDBuWpy7pD/qEE+YF8yLjPZIpjxPwWUUMV6yq2sbL+KawK4gp
        X9xaPWhyTJi+crCw==
From:   "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/kvm: Reserve KVM_FEATURE_MSI_EXT_DEST_ID
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Paolo Bonzini <pbonzini@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160397375001.397.5780307875241946260.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     5a169bf04cd2bfdbac967d12eb5b70915b29d7ee
Gitweb:        https://git.kernel.org/tip/5a169bf04cd2bfdbac967d12eb5b70915b29d7ee
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Mon, 19 Oct 2020 15:55:56 +01:00
Committer:     Paolo Bonzini <pbonzini@redhat.com>
CommitterDate: Wed, 28 Oct 2020 13:52:05 -04:00

x86/kvm: Reserve KVM_FEATURE_MSI_EXT_DEST_ID

No functional change; just reserve the feature bit for now so that VMMs
can start to implement it.

This will allow the host to indicate that MSI emulation supports 15-bit
destination IDs, allowing up to 32768 CPUs without interrupt remapping.

cf. https://patchwork.kernel.org/patch/11816693/ for qemu

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <4cd59bed05f4b7410d3d1ffd1e997ab53683874d.camel@infradead.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Documentation/virt/kvm/cpuid.rst     | 4 ++++
 arch/x86/include/uapi/asm/kvm_para.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/Documentation/virt/kvm/cpuid.rst b/Documentation/virt/kvm/cpuid.rst
index 7d81c0a..cf62162 100644
--- a/Documentation/virt/kvm/cpuid.rst
+++ b/Documentation/virt/kvm/cpuid.rst
@@ -92,6 +92,10 @@ KVM_FEATURE_ASYNC_PF_INT           14          guest checks this feature bit
                                                async pf acknowledgment msr
                                                0x4b564d07.
 
+KVM_FEATURE_MSI_EXT_DEST_ID        15          guest checks this feature bit
+                                               before using extended destination
+                                               ID bits in MSI address bits 11-5.
+
 KVM_FEATURE_CLOCKSOURCE_STABLE_BIT 24          host will warn if no guest-side
                                                per-cpu warps are expected in
                                                kvmclock
diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
index 812e9b4..950afeb 100644
--- a/arch/x86/include/uapi/asm/kvm_para.h
+++ b/arch/x86/include/uapi/asm/kvm_para.h
@@ -32,6 +32,7 @@
 #define KVM_FEATURE_POLL_CONTROL	12
 #define KVM_FEATURE_PV_SCHED_YIELD	13
 #define KVM_FEATURE_ASYNC_PF_INT	14
+#define KVM_FEATURE_MSI_EXT_DEST_ID	15
 
 #define KVM_HINTS_REALTIME      0
 
