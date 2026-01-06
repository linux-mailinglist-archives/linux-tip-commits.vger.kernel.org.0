Return-Path: <linux-tip-commits+bounces-7823-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A719CF7A4C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 06 Jan 2026 10:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BD303066299
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 Jan 2026 09:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A041F1E1DE5;
	Tue,  6 Jan 2026 09:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i6tbu7Bl"
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012052.outbound.protection.outlook.com [40.107.200.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A5E2DCF74;
	Tue,  6 Jan 2026 09:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767693212; cv=fail; b=mMRaByeC0Ho+ct4JJd0XGlvhxRb/uLi/+PtQ+XJwabVD2+iV9f5NHHO+nPxVkF5PEcZscTRNqdQcT5iTxAqHtnu/9tBNrsGfkrjeoF2CUYPhEpvqKnXYYIcTvU4rsWaGrwMaBP9KS35g8/JxPoQTl+O5M4Cuhhbj934Nvb4Twa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767693212; c=relaxed/simple;
	bh=bHeBxiWI4EpzS1MWTUUoQ1d7vTCOSpHzdwMKqLQdcE4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RAh2XCNTeoJlT+IiwQ6zEwAdCHSQ1bZJpdBRMgHRVxCmxaGHfNxSsSiOQB8xzceZHEPyM5QP/UoRYv2mmp2RkIVywqLFCOkJ04NfkZCJrXgnRU77L5yslkN75P22qx47roTW5ggpi5DvmW5YtuybSrl/Pd/Ib4pYrgSLlXzaVzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i6tbu7Bl; arc=fail smtp.client-ip=40.107.200.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frANBbCYmVsumOOSyVfz8xwAUWY3dlsyIaUZ9G7DWaUZCE5lW8K7r+CNbC2rB87hDNGb9bqv+ucy7dKSx5RO3L4KbL6fASMK+jkNf6bHYPPgOz/XPSaFXQWNQjG7sbsEPe0vaPjSna1k8904nQVz9bfIVeC7PsasmjWRw6kksQkaqnBgcNfd8BO6V248wEARbWIqDgusB5jFFdUYj3Pnywf+cRg80RNRi4bQ9ufmPHSYU5w4yxd5v5qVhlyyXIRkaW0jfeKZPNKUlR1ME2rlfd+EbWHefXf0watz3KPmzy6x/eiLqM7+eE8CuEYdHj6JF66O40TSGOyxhcrrjNfnAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1pmOV9dg2pVbgHPY1Sb9Iwx4NXL3Gu9WOjUThc8pcg=;
 b=UZxe9XxCOn1nZ/ZOsL6bRXza3AhIQBdfAPtKLHkBEoHfhw0n1MYEyEniS8uOiWybbyt45oOfdL+h+Hj0LSIyolFG98goamT01H6CsiMts488+D6byk6naCw5wmSEhSBmZVIWUK4qgUjCsN3eYX7Qkw6lG+hhyUYABIwKDd1YuHBV5VPEpCF9s9vQMRyNmQaGd/QgNFK3EXkuRP6PPVicdKHYyFkSR1SaPgdqYcp+PN/lwbcO2x2+D8kKO/VbHFLWb+Qu0WOo5MaCUMsd0sbLu1gI7vjo7kW2FscfG9zozSH/m4TXuoiYtzZvlpfPo+RRANycELoYJ/j6CqEK14xwpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1pmOV9dg2pVbgHPY1Sb9Iwx4NXL3Gu9WOjUThc8pcg=;
 b=i6tbu7BlSqqEonZMMG5Pl4bxYuVO418Us0qlnq5O6Rk/9eFC8xYEonizedBcHcva5fQ54mKGksFfyqiGdzc+vi+w2ZqhieF16ruvoxalef1YFOdYH7pgskNrDDa28JrsXIx0nBDPb5m+8OHVfyJHUBEtcQQPJnKYpRAJXOwMC9aiU9Xv+7LBWstddyVK30Jbq+5jGriBWq4ulhSEJ5nKf5TMvS/BNb63Za5suTIrQvEXSolp1MUTY7Pdr8UnRBk6oHO35WQXTukSP4Eyr/t/XbnWMRDQXJEjm1/7mYEIc8AQTrE9EuxnDXq2CcDxNw8XnOGOpYzYwjwoGl7OASGIzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by DM4PR12MB9070.namprd12.prod.outlook.com (2603:10b6:8:bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 09:53:28 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%7]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 09:53:27 +0000
Message-ID: <44509520-f29b-4b8a-8986-5eae3e022eb7@nvidia.com>
Date: Tue, 6 Jan 2026 09:53:23 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: irq/msi] PCI: dwc: Enable MSI affinity support
To: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
 Radu Rendec <rrendec@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20251128212055.1409093-4-rrendec@redhat.com>
 <176583448396.510.10427292538118156779.tip-bot2@tip-bot2>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <176583448396.510.10427292538118156779.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0492.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::17) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|DM4PR12MB9070:EE_
X-MS-Office365-Filtering-Correlation-Id: 9594ea0d-d877-4821-531f-08de4d0970d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmRnTFpiNHJnbHdMZlBjaE9pVWxoMm1RNkZCK0JWV1h6ZEZqRnI3Rkd1VXZ5?=
 =?utf-8?B?K21HZXRSWUtrb2NBZk5scWJiMGhRRVMyODFROG0vdjVSaXVyZHJRRXdqRGc4?=
 =?utf-8?B?c0JISXNDaGtzVDJjZTVyM1lYU3RiL3Yrd3BRckRlYWFpVE5JcDRaWHRzRDFX?=
 =?utf-8?B?YUNGQVpUa0pKMXRJMndxa2w3RjBqdXU1MDNwczhubGJxZ2Q0UGlGcU9manV0?=
 =?utf-8?B?bjdONDVjVmpKaS9YbHZPSm1ldmRINGs4aHJXZExTbUJWaHYrMDZzUlZCcnJM?=
 =?utf-8?B?b0dzTWN2RnFKOCthZ1RTbkFVQUd2akFGRy82TXpuL2E4dytmRGlNQlc1VnRD?=
 =?utf-8?B?N3IwaHloeVBpaWNFVzE1RVVoWlpkeC9Qa3VUZGYyMy9RWkV2bFdCbTJuNml1?=
 =?utf-8?B?K2VmUUFGMkNtMEZac0FpTkx4MnAxNzVJSEdheEQ2NGErakNTcXlYcjFUWGtv?=
 =?utf-8?B?S1drYU56OERrSE5jc2FFYndtdm54c0xwbUtPK3ZFMkhxLy95Rm1EaU4za0x3?=
 =?utf-8?B?UFYvRkRIQklkRTBteWtkSzhoQzJ5Y1B4S0VGeW52aHlialJUT2I0WFpTS2to?=
 =?utf-8?B?Q0hJSVBaaktGeE14eHFueFFZcjFXc2owNUNyZGxuZlA3YWtreG9ETzhKOWRS?=
 =?utf-8?B?QzROOHRwc0hDMVVCejc1aTRXTk00cDJmUWV4dEswaVJhRDFHNTNJdzhZbzkx?=
 =?utf-8?B?WS9uYXdOVzBZQWlQL3lOQTh5MXIzdzVPWmZXYmUyR3VsQklYRzNSWlBqU3NO?=
 =?utf-8?B?cDZrVjNZUDg0aktyYnBRNnh0eXJnWmZKemluWUdGYW41UXFGczhnNEp4Sk8y?=
 =?utf-8?B?dHpMMnlrYlVBMjJZOHFyRERmWXp4NExkRERmbkxVN0pOZWpFaElWZGx4dFBy?=
 =?utf-8?B?K2w5bUlTdHhmOXM2bXFnZFBZbUdNMm5nMXpPaFRobk9QR1lZV2p1TFhNY3JT?=
 =?utf-8?B?U1NuS2JXWnFQdnppNXpGZXlOWFF1SDY1YmY5NCtmdk1NUDNoZkhFUm9rTmdk?=
 =?utf-8?B?eUZIdFdRelpoVDJ3SCtXVjhGWkR3Y0drK2ZHWjJFVit1bXhKNVNheXh0NGJm?=
 =?utf-8?B?SmZVUzV1SFZtbXJveDBVUWNEdEUybGVYWnkyOVhQTGxQbnF3OXRZWTVNY3lw?=
 =?utf-8?B?Y29aNjV0Qk11YkpMOUd5QW1WT3hrVEtVTGx1bm00eFNYVlpjd2JwQ0V4QmNO?=
 =?utf-8?B?cHpQbzFHUHR1R2JnbzFxODhNZjh0dXVJV01RYTlKd2lYazhDNlUra0pLUVdN?=
 =?utf-8?B?QlpNT2tmQXk3VlBUWHp2SlYwWXl5b053Ym5jWGo3RVhqZTBBamhYSjdGZVhs?=
 =?utf-8?B?RXdrR3lITmJRSWg4SDdrSkxqTktMeEhqUVJMYkh4YzFEVWg0Y2I0cjV5ZkVl?=
 =?utf-8?B?aDM5MVgzcTROWUZQNjYrNkxsK0hXL2dMa3VMTHMzR0lXRnRMZCtpS3p1WlM1?=
 =?utf-8?B?eHJrRXd4czBKRngrM3dsc09ldzJGODEyTHJrUTdaMFgrUzkzRVJvY0JjSGJl?=
 =?utf-8?B?UEJ1WjYyVnY5bVVrWk1zQVJjSGpPYTB4T082dTFkdWxOSGJYNGp1MUhvUlN2?=
 =?utf-8?B?ai9WMUVnYmpBQVVVaC9zUHdCcVBpRXoxZWFGQnlUb0FNN3pYTW94TU9qZk5a?=
 =?utf-8?B?U0R5VkJSNjVmaVc4b3NaOEU4Y3BtSGR4KzgrOG82ZzFHUExhNlF5MzJZd3NY?=
 =?utf-8?B?MmdhRHVhRVU0c05HZjExVU5NUEYxNlZzSy9aeE1ROEQ2aU0rSDBheVZNajVo?=
 =?utf-8?B?d3JmdGd2Z2tVS1lVaTNYTmhkS3RNaW1LWHhXYmI0ZnVFVklqTCtyRCtGd1Bi?=
 =?utf-8?B?T21aWFdBZTRKTmVuYWR0cWliZmQ4OVBFbDdUTFhqUjB6ODBCVW9XUGlMWlE2?=
 =?utf-8?B?S0dERXB1L2hjZXdXK1lkV3lYMG5BUDZrRXZwSDdvdXQxbXVlNzlKLzFvQ1FX?=
 =?utf-8?Q?yCv3SjgGFZUKKfHVdn/288wI4/bonQbz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3VyTTFuSW1UYk55TWhQbndhM1VoN2pHQ0hLR2hzSXNrVGNtY2R6V1dZbmR2?=
 =?utf-8?B?azJkWDRnSTExMFRneDA3YlJIR2hrdkdpTU5JbDhMNGovR2Z4ZUJKRklVV2V1?=
 =?utf-8?B?QW54VFMwczJWaTlVSFB2VDV3ejNRWnJTSVBzYkhsNHJHc1RONklybG4waTFT?=
 =?utf-8?B?VDhZRzNPQ0tkdlY5Z0MrVjlFUnltSnhSVHQzeHY5bFRqL0JXbjltRmVOMUtl?=
 =?utf-8?B?MVM5a213Qm54dEpCSnRNdHFubU1VTHFhSGhENmJEdk1XcWF5eDZCYzhpRDhB?=
 =?utf-8?B?bU1TRkNrNU1DajM3UkJmSnV5Z29weXlTVEFMNitxaFNzM2FuN0tZcTR4UWZ2?=
 =?utf-8?B?cnBTVmVzRGNQL2kyQW1IS3ZxSkZQZWswdnNOUFNEeFVHVWs0RHB6dm1OTFMv?=
 =?utf-8?B?cTZCT2s0T3ZTNkFDZW5SK0ptUm1iU0x5Y25NYjRvSThkZHZ3T3JsMnFSRXpB?=
 =?utf-8?B?azhOeWJZbmI1Vm9seWhMdEFsODFtWWdrcm9mc2ppSitUSWlUQzYzVHpaZ05J?=
 =?utf-8?B?UTZsTmFjdEUwWjJMUlU4R3BCaXlJdHBCaGJ5TjRTMlFVU0UxRDV3OXFFSmFM?=
 =?utf-8?B?NVpYQjJCdnA5TmJHMWREYnBIblVBa0JoNDM2a3MwRmxGbVh4d0xtSUNHaTNr?=
 =?utf-8?B?bzJYTmFxUi83OW5mU3hlN1UwMk5pZzZicHNFOTJxa2x5ekFPRStuWXhneG1B?=
 =?utf-8?B?M0R0NEg3TkN1dmdzaFBUcDBtQmFoYW9TSnhydUlsSm5jL2VLS21NOFNVRVpt?=
 =?utf-8?B?dUxrcnhxL0xKS0RSTlYxcEVraEIyNmcrMUFFZGtFT3BhelMyZ3hkc1RVelNx?=
 =?utf-8?B?K0ZBYnlobGh4elM4V05Uc3ZXdEt2Q01GQmVLbCs0VHhYVnZhc3UyUllJMTR5?=
 =?utf-8?B?bXk5R3lGU0FjRmhjdll2RzdWMUsyNG1lL0N6NlFjM1pUbDhoN2drTm9zMklE?=
 =?utf-8?B?Tm52UHhYR2FXVTd3SVdlbm9HMzBHb3hsV3BlVUFTV0NyYzB3RFN6UWlYRkRR?=
 =?utf-8?B?ZWtJbzM2NS9FVUl5U1RUWUdDaVBMV2ZFdWlTSlZ3Ulk3SXpydTR6dzF4alJt?=
 =?utf-8?B?cklsMXJETzlGTFM1OWtsazN6M0M5VHFnT1A1bGsxVTJzY21XMHBjVkhGZFcv?=
 =?utf-8?B?UXFjbkFoekQzV1VNK01sTkd2TFYyeHpudlBQaUs3d0t4T1hYaVYvYlluT0Zl?=
 =?utf-8?B?UHRiZjkrV21Wc1NCZU1qbHhubVNKNjdIVkZHR1pQRE9NYzhScHpQdjRDWWhY?=
 =?utf-8?B?OGRVd3NGc0FRUXBRL1Y4UHplNkQ2Rzk2Nlp3Ukd3dERjNE80MmJiUkp4Nzdl?=
 =?utf-8?B?aWEwbXNjeEtFSzlZZU5sMzUyRmhMUHN4Q2ZKMlF6NEZQYlVIMWlrQUFpQUhu?=
 =?utf-8?B?UmgzRkZMeUpKWE8vK05QMWVnRnkxTGFhV284bmRhd3I4U2UwODRpdURQWFRC?=
 =?utf-8?B?YXgySE9icTdEenozSGkvVnFncG1oVmJRaUZsZ1ZoOU51Y2dCWENFTWM1TGJp?=
 =?utf-8?B?aW9CdDI3d1JzT2liamNsY2JHZ2ZRZ282R3Z5K2ZUSkw4Q1dKQ3g3R2xRSFZO?=
 =?utf-8?B?WmJoLzRvZXRtWGpPYVpZa0IzWlF4S1VIamw2aG9mSVRoWmp4NHNVTEFwT1Fv?=
 =?utf-8?B?VGlITHNtL1NhdDRDeVN6dy9uYjNLUCs0WWlMNjcrUForcmNXdVZHT3JKQTB3?=
 =?utf-8?B?emhzdTJ3SmMvb2tBT1RieDZRUTQvSWFjZ1dVVTVHWS91bURWZXJ6UGs4aFZm?=
 =?utf-8?B?c2ZhaWI4YnJrVmplUm1SMk5ZbGswWk9WaCtQa2hHUFFGVHFQQ2JmOVhSTDFM?=
 =?utf-8?B?M1NnN1RvV3ZvVFVaMjdLVWxzaTVnL09QK2dHd3F4bk5HanRTSTJ3NWJWclFu?=
 =?utf-8?B?Z1dKZlJTZ3RsbVUvLzdqZUpZam55ZUF6VWhwa3ZSMzZ4aFFFU05DY3E0aG9U?=
 =?utf-8?B?R1pYd2R3VC9EUUt3MWh1NXdRNUQzYVJUMWUvYmFGbFRQYTdqUGNSQ3VBZzJG?=
 =?utf-8?B?YmxQVEo2aG9rVWl1aUxPY2ZCOG0yZ2h1Q3cvZ2NBSmZUMDE1eGV6clFxRk53?=
 =?utf-8?B?dkxvSlp1NERWdDZram5Dc3Uwd0VjeWY4YmpTRDVuUDBvbHRTdjU4R3ZCVzZD?=
 =?utf-8?B?UlU3OWZaR3VMbmt5OUNDMVhJREI0SklpbzkyUFRIVnBMTkY0UFRkQjYxL1ly?=
 =?utf-8?B?UHYwc0VWRGRLNjlZTlR6MENvKzg4Mkg3QmNqd2hqQTZYRFJuRUtXRFZmOVBr?=
 =?utf-8?B?V1ZIOW9SQ0I5Y1N2SUw3YkRQbWdsb0RzNkRoNmgxekxCb1JqamhKWm44RGlz?=
 =?utf-8?B?VjhTT1N6SHNsNS9XcUlBZklTNzlDM25zaGdPblpEdm5GUzk5WllrZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9594ea0d-d877-4821-531f-08de4d0970d9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 09:53:27.8968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PXTcJpgIpuTtt7/e9gGzb0ymaEFdAlM7pMNl+r9oYf32MNiidiSXF5GBHx1Mncavz0l4RFnaI3HaWX58eK3TEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9070

Hi Radu,

On 15/12/2025 21:34, tip-bot2 for Radu Rendec wrote:
> The following commit has been merged into the irq/msi branch of tip:
> 
> Commit-ID:     eaf290c404f7c39f23292e9ce83b8b5b51ab598a
> Gitweb:        https://git.kernel.org/tip/eaf290c404f7c39f23292e9ce83b8b5b51ab598a
> Author:        Radu Rendec <rrendec@redhat.com>
> AuthorDate:    Fri, 28 Nov 2025 16:20:55 -05:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Mon, 15 Dec 2025 22:30:48 +01:00
> 
> PCI: dwc: Enable MSI affinity support
> 
> Leverage the interrupt redirection infrastructure to enable CPU affinity
> support for MSI interrupts. Since the parent interrupt affinity cannot
> be changed, affinity control for the child interrupt (MSI) is achieved
> by redirecting the handler to run in IRQ work context on the target CPU.
> 
> This patch was originally prepared by Thomas Gleixner (see Link tag below)
> in a patch series that was never submitted as is, and only parts of that
> series have made it upstream so far.
> 
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Radu Rendec <rrendec@redhat.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/linux-pci/878qpg4o4t.ffs@tglx/
> Link: https://patch.msgid.link/20251128212055.1409093-4-rrendec@redhat.com


With next-20260105 I am observing the following warning on the Tegra194 
Jetson AGX platform ...

  WARNING KERN genirq: irq_chip DW-PCI-MSI-0001:01:00.0 did not update
   eff. affinity mask of irq 171

Bisect is point to this commit. This platform is using the driver 
drivers/pci/controller/dwc/pcie-tegra194.c. Is there some default 
affinity that we should be setting to avoid this warning?

Thanks
Jon

-- 
nvpublic


