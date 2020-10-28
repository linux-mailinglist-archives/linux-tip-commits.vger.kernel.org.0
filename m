Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049DD29E0AF
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 02:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbgJ2BXX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 28 Oct 2020 21:23:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:47940 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729805AbgJ1WDm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 28 Oct 2020 18:03:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B92E9ABAE;
        Wed, 28 Oct 2020 09:54:25 +0000 (UTC)
Date:   Wed, 28 Oct 2020 10:54:24 +0100
From:   Joerg Roedel <jroedel@suse.de>
To:     Erdem Aktas <erdemaktas@google.com>, dcovelli@vmware.com
Cc:     linux-kernel@vger.kernel.org,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        linux-tip-commits@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>
Subject: Re: [tip: x86/seves] x86/vmware: Add VMware-specific handling for
 VMMCALL under SEV-ES
Message-ID: <20201028095424.GJ22179@suse.de>
References: <20200907131613.12703-65-joro@8bytes.org>
 <159972972557.20229.773744278485296601.tip-bot2@tip-bot2>
 <CAAYXXYwFxuK7NvaXTebag0vczRRRyYNRdVPd66GeiCz9_2TXCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAYXXYwFxuK7NvaXTebag0vczRRRyYNRdVPd66GeiCz9_2TXCA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Tue, Oct 27, 2020 at 04:19:45PM -0700, Erdem Aktas wrote:
> Looking at the VMWARE_VMCALL(cmd, eax, ebx, ecx, edx) definition, it
> seems to me only 4 registers are required to be shared with
> hypervisor. I don't know much about vmware but is not
> vmware_sev_es_hcall_prepare expose more registers than needed and also
> vmware_sev_es_hcall_finish might let the hypvervisor to modify
> additional registers which are not used?
> 
> Just checking if this is intentional and what I am missing here.

Original patch is from Doug, maybe he can clarify what needs to be
shared. I only adapted it to the call-backs.

Doug?

Regards,

	Joerg
